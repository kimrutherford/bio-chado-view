package SmallRNA::Runable::CreateIndexRunable;

=head1 NAME

SmallRNA::Runable::CreateIndexRunable - Create an index of a GFF or FASTA file,
                                        indexing by read sequence

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Runable::CreateIndexRunable

=over 4

=back

=head1 COPYRIGHT & LICENSE

Copyright 2009 Kim Rutherford, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 FUNCTIONS

=cut

use strict;
use warnings;
use Carp;

use Moose;

use SmallRNA::Index::Manager;

extends 'SmallRNA::Runable::SmallRNARunable';

=head2

 Function: Create an index from a GFF3 or FASTA file, with the read sequence as the key
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

    my $input_format_type = $input_pipedata->format_type()->name();

    if ($input_format_type !~ '^(gff3|fasta)$') {
      croak('must have GFF3 or FASTA as input');
    }

    my $output_type = $input_format_type . '_index';
    my $data_dir = $self->config()->data_directory();

    my $input_file_name = $data_dir . '/' . $input_pipedata->file_name();

    my $output_file_name = $input_file_name;

    if ($output_file_name =~ s/\.$input_format_type$/.$output_type/) {
      my $manager = SmallRNA::Index::Manager->new();

      $manager->create_index(input_file_name => $input_file_name,
                             index_file_name => $output_file_name,
                             input_file_type => $input_format_type);

      $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                            file_name => $output_file_name,
                            format_type_name => 'seq_offset_index',
                            content_type_name => $output_type);


    } else {
      croak("pattern match failed on: ", $output_file_name);
    }
  };
  $self->schema->txn_do($code);
}

1;
