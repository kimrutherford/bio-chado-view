package SmallRNA::DBLayer::Loader;

=head1 NAME

SmallRNA::DBLayer::Loader - Load data into the database

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::DBLayer::Loader

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
use Carp;
use Params::Validate qw(:all);

=head2 new

 Usage   : my $loader = SmallRNA::DBLayer::Loader(schema => $schema);
 Function: Return a helper object for loading into the database
 Args    : a SmallRNA::DB schema

=cut
sub new
{
  my $class = shift;

  my %params = validate(@_, { schema => 1 });

  my $self = {};

  $self->{schema} = $params{schema};

  return bless $self, $class;
}

=head2 add_organism

 Usage   : my $organism_object = $loader->add_organism(genus => "Arabidopsis",
                                                       species => "thaliana");
 Function: Create and return a new organism object
 Args    : genus and species

=cut
sub add_organism
{
  my $self = shift;
  my %params = validate(@_, { genus => 1, species => 1 });

  my $genus = $params{genus};
  my $species = $params{species};

  my $rs = $self->{schema}->resultset('Organism');
  my $new_org = $rs->create({
                             genus  => $genus,
                             species => $species
                            });
  return $new_org;
}

=head2 add_person

 Usage   : my $person_object = $loader->add_person(first_name => "First",
                                                   last_name => "Last",
                                                   organisation => $organisation);
 Function: Create and return a new person object
 Args    : first and last names

=cut
sub add_person
{
  my $self = shift;
  my %params = validate(@_, { first_name => 1, last_name => 1,
                              user_name => 1, password => 1,
                              organisation => 1});

  my $rs = $self->{schema}->resultset('Person');
  return $rs->create({
                      first_name => $params{first_name},
                      last_name => $params{last_name},
                      user_name => $params{user_name},
                      password => $params{password},
                      organisation => $params{organisation}
                     });
}

=head2 add_sequencingrun

 Usage   : my $sequencing_run =
             $loader->add_sequencingrun(run_identifier => 'SL1.XXXXXXX',
                                        sequencing_centre_name => 'CRUK CRI',
                                        multiplexing_type_name => 'non-multiplexed',
                                        sequencing_type_name => 'Illumina' });
 Function: Create and return a Sequencingrun object
 Args    : run_identifier - a (unique) name for the run, generally supplied by
                            the sequencing facility
           sequencing_centre_name - a Organisation name that did the sequencing
           multiplexing_type_name - a cvterm describing the multiplexing type
           sequencing_type_name - a cvterm describing sequencing type

=cut
sub add_sequencingrun
{
  my $self = shift;

  my %params = validate(@_, { run_identifier => 1,
                              sequencing_centre_name => 1,
                              multiplexing_type_name => 1,
                              sequencing_sample => 1,
                              sequencing_type_name => 1 });


  my $run_identifier = $params{run_identifier};
  my $sequencing_centre_name = $params{sequencing_centre_name};
  my $multiplexing_type_name = $params{multiplexing_type_name};
  my $sequencing_sample = $params{sequencing_sample};
  my $sequencing_type_name = $params{sequencing_type_name};

  my $seq_centre = $self->_find('Organisation',
                                                   name => $sequencing_centre_name);
  my $process_conf;

  my $multiplexing_type = $self->_find('Cvterm',
                                                name => $multiplexing_type_name);
  my $sequencing_type = $self->_find('Cvterm',
                                              name => $sequencing_type_name);
  my $unknown_quality = $self->_find('Cvterm',
                                              name => 'unknown');
  my %sequencing_run_args = (
                             identifier => $run_identifier,
                             sequencing_type => $sequencing_type,
                             multiplexing_type => $multiplexing_type,
                             sequencing_centre => $seq_centre,
                             sequencing_sample => $sequencing_sample,
                             quality => $unknown_quality
                            );

  return $self->_create('Sequencingrun',
                                 {
                                  %sequencing_run_args
                                 });
}

=head2 add_sequencingrun_pipedata

 Usage   : my $pipedata =
             $loader->add_sequencingrun_pipedata($smallrna_config,
                                                 $sequencing_run,
                                                 $file_name, 'RNA');
 Function: Create and return a new Pipedata object for the given sequencing_run
 Args    : config - a SmallRNA::Config object
           sequencing_run - a Sequencingrun object
           file_name - a file name of a fastq file from the sequencing run
           molecule_type - 'DNA' or 'RNA'

=cut
sub add_sequencingrun_pipedata
{
  my $self = shift;
  my $config = shift;
  my $sequencing_run = shift;
  my $file_name = shift;
  my $molecule_type = shift;

  my $full_file_name = $config->data_directory() . "/$file_name";

  if (!-e $full_file_name) {
    croak "file $file_name doesn't exist in data directory: ", $config->data_directory();
  }

  my $process_conf;

  my $seq_centre_name = $sequencing_run->sequencing_centre()->name();
  my $multiplexing_type_name = $sequencing_run->multiplexing_type()->name();
  my $multiplexed;

  if ($multiplexing_type_name eq 'non-multiplexed') {
    $multiplexed = 0;
  } else {
    $multiplexed = 1;
  }

  if ($seq_centre_name eq 'CRUK CRI') {
    $process_conf = $self->_find('ProcessConf',
                                 detail => 'CRI');
  } else {
    if ($seq_centre_name eq 'Sainsbury') {
      $process_conf = $self->_find('ProcessConf',
                                   detail => 'Sainsbury');
    } else {
      croak "unknown sequencing centre name: $seq_centre_name\n";
    }
  }

  my $finished_status = $self->_find('Cvterm', name => 'finished');

  my %pipeprocess_args = (
                          description => "Sequencing by $seq_centre_name",
                          process_conf => $process_conf,
                          status => $finished_status,
                         );

  my $pipeprocess = $self->_create('Pipeprocess',
                                   {
                                    %pipeprocess_args
                                   });

  my $pipedata_format_type;
  my $pipedata_content_type;

  if ($file_name =~ /\.fa$|\.fasta$/) {
    $pipedata_format_type = $self->_find('Cvterm', name => 'fasta');
    $pipedata_content_type = $self->_find('Cvterm', name => 'small_rna');
  } else {
    $pipedata_format_type = $self->_find('Cvterm', name => 'fastq');

    if ($molecule_type eq 'RNA') {
      if ($multiplexed) {
        $pipedata_content_type = $self->_find('Cvterm', name => 'multiplexed_small_rna_reads');
      } else {
        $pipedata_content_type = $self->_find('Cvterm', name => 'raw_small_rna_reads');
      }
    } else {
      $pipedata_content_type = $self->_find('Cvterm', name => 'raw_genomic_dna_reads');
    }
  }

  my $ctx = Digest::MD5->new;

  my $pipedata = $self->_create('Pipedata',
                                {
                                 file_name => $file_name,
                                 format_type => $pipedata_format_type,
                                 content_type => $pipedata_content_type,
                                 file_length => -s $full_file_name,
                                 generating_pipeprocess => $pipeprocess
                                });

  return ($pipedata, $pipeprocess);
}

=head2

 Usage   : my $project = $loader->create_with_prefix('Pipeproject',
                                                     'name', 'P_',
                                                     { description => $ARGV[0],
                                                       type => $project_type,
                                                       owner => $owner
                                                     });
 Function: Create and return a new object, picking a unique identifier for it.
           Works by reading the given field of the type and finding the next
           identifier to use.  eg. if the prefix is 'P_' and the database has
           'P_0' and 'P_1' already, choose 'P_2' as the new identifier.
 Args    : $type - the type to create
           $field_name - the field name to use to the identifier
           $prefix - the prefix
           $args - the fields and values for the new object

=cut
sub create_with_prefix
{
  my $self = shift;
  my $type = shift;
  my $field_name = shift;
  my $prefix = shift;
  my $args = shift;

  my $schema = $self->{schema};

  my $rs = $schema->resultset($type)->search_like({$field_name, "$prefix%"});

  my $max = -1;

  while (defined (my $obj = $rs->next())) {
    if ($obj->$field_name() =~ /^$prefix(\d+)/) {
      if ($1 > $max) {
        $max = $1;
      }
    }
  }

  return $self->_create($type, { $field_name, $prefix . ($max + 1), %$args });
}


sub _create
{
  my $self = shift;
  my $type = shift;
  my $args = shift;

  my $schema = $self->{schema};

  return $schema->create_with_type($type, $args);
}

sub _find
{
  my $self = shift;

  my $schema = $self->{schema};

  my $obj = $schema->find_with_type(@_);

  if (defined $obj) {
    return $obj;
  } else {
    warn "couldn't find $_[0]\n";
  }
}



1;
