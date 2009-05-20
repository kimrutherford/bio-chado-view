package SmallRNA::Runable::GenomeMatchingReadsRunable;

=head1 NAME

SmallRNA::Runable::GenomeMatchingReadsRunable - Create a file containing only
                                                genome matching reads

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Runable::GenomeMatchingReadsRunable

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
use Moose;
use Carp;

use Bio::SeqIO;

extends 'SmallRNA::Runable::SmallRNARunable';

sub run
{
  my $self = shift;
  my $schema = $self->schema();

  my $code = sub {
    my $out_content_term_name = 'genome_matching_srna';
    my $out_format_term_name = 'fasta';
    my $pipeprocess = $self->pipeprocess();

    my @input_pipedatas = $pipeprocess->input_pipedatas();
    if (@input_pipedatas != 2) {
      croak ("pipeprocess ", $pipeprocess->pipeprocess_id(),
             " doesn't have two input pipedata\n");
    }
    
    my $non_redundant_reads_data;
    my $gff_data;

    my $non_redundant_type = 'non_redundant_small_rna';

    if ($input_pipedatas[0]->content_type()->name() eq $non_redundant_type) {
      $non_redundant_reads_data = $input_pipedatas[0];
      $gff_data = $input_pipedatas[1];
    } else {
      $non_redundant_reads_data = $input_pipedatas[1];
      $gff_data = $input_pipedatas[0]; 
    }

    my $data_dir = $self->config()->data_directory();

    my $fasta_file_name = $data_dir . '/' . $non_redundant_reads_data->file_name();
    my $out_file_name = $fasta_file_name;

    my $new_suffix = ".$out_content_term_name.$out_format_term_name";

    $out_file_name =~ s/(\.$non_redundant_type.fasta)?$/$new_suffix/;

    my $gff_file_name = $data_dir . '/' . $gff_data->file_name();

    my %genome_reads = ();

    open my $gff_file, '<', $gff_file_name
      or croak "can't open $gff_file_name for reading: $!\n";

    while (my $line = <$gff_file>) {
      next if $line =~ /^\s*#/;

      if ($line =~ /Name=(\w+)/) {
        $genome_reads{$1} = 1;
      } else {
        croak "can't find Name in gff3 line: $line\n";
      }
    }

    close $gff_file or croak "can't close $gff_file_name: $!";

    my $seq_in = Bio::SeqIO->new('-file' => "<$fasta_file_name",
                                 '-format' => 'Fasta');

    my $seq_out = Bio::SeqIO->new('-file' => ">$out_file_name",
                                  '-format' => 'Fasta');

    warn "opened: $out_file_name for $fasta_file_name $gff_file_name\n";

    # write each entry in the input file to the output file
    while (my $seq = $seq_in->next_seq) {
      my $sequence = $seq->seq();
      if (exists $genome_reads{$sequence}) {
        $seq_out->write_seq($seq);
      }
    }

    $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                          file_name => $out_file_name,
                          format_type_name => $out_format_term_name,
                          content_type_name => $out_content_term_name);
  };
  $self->schema->txn_do($code);
}

1;

