package SmallRNA::Runable::SSAHASearchRunable;

=head1 NAME

SmallRNA::Runable::SSAHASearchRunable - Run, parse and save the results of a
                                        SSAHA search

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Runable::SSAHASearchRunable

=over 4

=back

=head1 COPYRIGHT & LICENSE

Copyright 2009 Kim Rutherford, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 FUNCTIONS

none - see SmallRNA::RunableI;

=cut

use strict;
use warnings;
use Carp;
use Moose;

use SmallRNA::Process::SSAHASearchProcess;

extends 'SmallRNA::Runable::SmallRNARunable';

=head2

 Function: Run SSAHASearchProcess for this Runable/pipeprocess and store the
           name of the resulting gff file in the pipedata table.
 Returns : nothing - either succeeds or calls die()

=cut
sub run
{
  my $self = shift;
  my $schema = $self->schema();

  my $code = sub {
    my $pipeprocess = $self->pipeprocess();

    my @input_pipedatas = $pipeprocess->input_pipedatas();
    if (@input_pipedatas > 1) {
      croak ("pipeprocess ", $pipeprocess->pipeprocess_id(),
             " has more than one input pipedata\n");
    }
    my $input_pipedata = $input_pipedatas[0];

    my @samples = $input_pipedata->samples();

    if (@samples != 1) {
      croak("pipedata has more than one sample, can't continue: ",
            $input_pipedata->file_name(), "\n");
    }

    my $c = $self->config()->{programs}{ssaha};

    my $sample = $samples[0];

    my $genome_aligned_srna_reads = 'genome_aligned_srna_reads';
    my $data_dir = $self->config()->data_directory();
    my $detail = $pipeprocess->process_conf()->detail();

    if ($detail =~ /versus: (\S+)/) {
      my $versus = $1;
      my @sample_ecotypes = $sample->ecotypes();

      my $org_config = undef;

      my $org_full_name = undef;

      for my $ecotype (@sample_ecotypes) {
        $org_full_name = $ecotype->organism()->full_name();
        $org_full_name =~ s/ /_/g;
        $org_config = $c->{organisms}{$org_full_name};

        if (defined $org_config) {
          last;
        }
      }

      if (!defined $org_config) {
        croak "can't find organism configuration for ", $sample->name(), "\n";
      }

      if (!defined $org_config->{database_files}{$versus}) {
        die "can't find versus: $versus\n";
      }

      my $db_file_name = $c->{root} . '/' . $org_config->{database_files}{$versus};

      my $ssaha_path = $c->{path};

      my $input_file_name = $input_pipedata->file_name();
      my $gff_file_name = $input_file_name;

      my $new_suffix = ".v_${org_full_name}_$versus.gff3";

      $gff_file_name =~ s/\.non_redundant_small_rna\.fasta/$new_suffix/;

      SmallRNA::Process::SSAHASearchProcess::run(input_file_name =>
                                                   "$data_dir/" . $input_file_name,
                                                 gff_source_name => $sample->name(),
                                                 ssaha_path => $ssaha_path,
                                                 output_gff_file_name =>
                                                   "$data_dir/" . $gff_file_name,
                                                 database_file_name =>
                                                   $db_file_name);

      $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                            file_name => $gff_file_name,
                            format_type_name => 'gff3',
                            content_type_name => $genome_aligned_srna_reads);

    } else {
      croak ("can't understand detail: $1 for pipeprocess: ",
             $pipeprocess->pipeprocess_id());
    }

  };
  $self->schema->txn_do($code);
}

1;

