package SmallRNA::ProcessManager;

=head1 NAME

SmallRNA::ProcessManager - An in-memory store of the ProcessConf
                             configuration

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::ProcessManager

You can also look for information at:

=over 4

=back

=head1 COPYRIGHT & LICENSE

Copyright 2009 Kim Rutherford, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 FUNCTIONS

=cut

use strict;
use Params::Validate qw(:all);
use Set::CrossProduct;

=head2 new

 Usage   : my $conf_store = SmallRNA::ProcessManager->new(schema => $schema);
 Function: Create and return a new ProcessManager object
 Args    : schema - the SmallRNA::DB object

=cut
sub new
{
  my $class = shift;
  my $self = { validate(@_, { schema => 1 }) };

  bless $self, $class;

  return $self;
}

sub _make_bit
{
  my ($conf, $input) = validate_pos(@_, 1, 1);
  my $content_type = $input->content_type();
  my $format_type = $input->format_type();
  my $content_type_id = $content_type->cvterm_id();
  my $format_type_id = $format_type->cvterm_id();
  my $conf_id = $conf->process_conf_id();

  # samples where there is a pipedata of the appropriate type for this
  # input, but there isn't an existing pipeprocess for the process_conf

  my $org_constraint = '';

  if (defined $input->ecotype()) {
    my $organism_full_name = $input->ecotype()->organism()->full_name();
    $org_constraint =
      "AND me.sample_id IN
        (SELECT sample FROM sample_ecotype, ecotype, organism
          WHERE sample_ecotype.ecotype = ecotype.ecotype_id
            AND ecotype.organism = organism.organism_id
            AND organism.genus || ' ' || organism.species = '$organism_full_name')";
  }

  return qq{
    me.sample_id in (
      SELECT sample_pipedata.sample
        FROM sample_pipedata, pipedata
       WHERE sample_pipedata.pipedata = pipedata.pipedata_id
         AND pipedata.content_type = $content_type_id
         AND pipedata.format_type = $format_type_id
$org_constraint
         AND NOT pipedata.pipedata_id IN (
           SELECT pipeprocess_in_pipedata.pipedata
             FROM pipeprocess_in_pipedata, pipeprocess
            WHERE pipeprocess_in_pipedata.pipeprocess = pipeprocess.pipeprocess_id
              AND pipeprocess.process_conf = $conf_id
         )
    )
  };
}

# find the sets of pipedatas from the sample that can be input for the process
sub _find_pipedata
{
  my ($sample, $process_conf) = @_;

  my @results = ();

  my @inputs = $process_conf->process_conf_inputs();

  for my $input (@inputs) {
    my $content_type = $input->content_type();
    my $format_type = $input->format_type();

    my @matching_pipedatas = ();

    my $cond = {
      content_type => $content_type->cvterm_id(),
      format_type => $format_type->cvterm_id()
    };

    my $matching_rs =
      $sample->sample_pipedatas()->search_related('pipedata', $cond);

    while (my $pipedata = $matching_rs->next()) {
      push @matching_pipedatas, $pipedata;
    }

    push @results, [@matching_pipedatas];
  }

  my $cross = Set::CrossProduct->new([@results]);

  if (@inputs == 1) {
    return map { [ $_] } @{$results[0]};
  } else {
    return $cross->combinations();
  }
}

sub _create_sample_proc
{
  my ($schema, $sample, $process_conf, $existing_processes) =
    validate_pos(@_, (1) x 4);

  my @retlist = ();

  my @input_pipedata = _find_pipedata($sample, $process_conf);

  for my $input_pipedata_ref (@input_pipedata) {
    my @input_pipedata = @{$input_pipedata_ref};

    my $key = (join '_', map { $_->pipedata_id() } @input_pipedata) . '_'
      . $process_conf->process_conf_id();

    if (exists $existing_processes->{$key}) {
      # we've created this process already, maybe because it's a remove adaptors
      # process for a multiplexed fastq file and we see the fastq file once per
      # sample
      next;
    } else {
      $existing_processes->{$key} = 1;
    }

    my $process_conf_name = $process_conf->type()->name();
    my $not_started_status = $schema->find_with_type('Cvterm', name => 'not_started');
    my $description = "processing with conf: $process_conf_name";

    if (defined $process_conf->detail()) {
      $description .= ' ' . $process_conf->detail();
    }

    my %pipeprocess_args = (
      description => $description,
      process_conf => $process_conf,
      status => $not_started_status
     );


    my $pipeprocess = $schema->create_with_type('Pipeprocess',
                                                  {
                                                    %pipeprocess_args
                                                  }
                                                );

    for my $pipe_data (@input_pipedata) {
      $pipeprocess->add_to_input_pipedatas($pipe_data);
    }

    $pipeprocess->update();

    push @retlist, $pipeprocess;
  }

  return @retlist;
}

=head2 create_new_pipeprocesses

 Usage   : my @pipeprocess = $manager->create_new_pipeprocesses();
 Function: Create and return all pipeprocesses that can be run given the
           current process_conf table.  The pipeprocess table will be changed.
 Args    : none

=cut
sub create_new_pipeprocesses
{
  my ($self) = validate_pos(@_, 1);

  my $schema = $self->{schema};

  my @retlist = ();

  # we query each ProcessConf object then:
  #   - find all samples that have pipedata objects that are inputs for the
  #     ProcessConf and that do not have an existing pipeprocess with the
  #     pipedata as input
  #   - for each sample we found, create any pipeprocesses that are needed

  my $code = sub {
    my $needs_processing_term = 
      $schema->find_with_type('Cvterm', name => 'needs processing');

    my $process_conf_rs = $schema->resultset('ProcessConf');

    while (defined (my $process_conf = $process_conf_rs->next())) {
      my @inputs = $process_conf->process_conf_inputs();

      next unless @inputs > 0;

      my @where_bits = map {
        _make_bit($process_conf, $_);
      } @inputs;

      my $where = join ' AND ', @where_bits;
      $where .= ' AND processing_requirement = ' . $needs_processing_term->cvterm_id();

      my $rs = $schema->resultset('Sample')->search({}, { where => $where });

      # keep a map so we don't create the same process twice, for example when
      # a fastq file contains more than one sample - the query above will return
      # all the samples for the sequencing run corresponding to the fastq file,
      # all of which have the same fastq file as input
      my %existing_processes = ();

      while (my $sample = $rs->next()) {
        push @retlist, _create_sample_proc($schema, $sample, $process_conf,
                                           \%existing_processes);
      }
    }
  };

  $schema->txn_do($code);

  return @retlist;
}

1;
