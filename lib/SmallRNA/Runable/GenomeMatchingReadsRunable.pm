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
    my $out_content_type = 'genome_matching_srna';
    my $fasta_term_name = 'fasta';
    my $tsv_term_name = 'tsv';
    my $pipeprocess = $self->pipeprocess();

    my @input_pipedatas = $pipeprocess->input_pipedatas();
    if (@input_pipedatas != 1) {
      croak ("pipeprocess ", $pipeprocess->pipeprocess_id(),
             " must have one input pipedata\n");
    }

    my $gff_data = $input_pipedatas[0];

    my $data_dir = $self->config()->data_directory();

    my $gff_file_name = $data_dir . '/' . $gff_data->file_name();

    my $gff_content_type = $gff_data->content_type()->name();
    my $gff_format_type = $gff_data->format_type()->name();

    my $fasta_out_file_name = $gff_file_name;
    my $tsv_out_file_name = $gff_file_name;

    my $old_suffix = ".$gff_content_type.$gff_format_type";

    my $new_suffix = ".$out_content_type.$fasta_term_name";
    $fasta_out_file_name =~ s/(\Q$old_suffix\E)?$/$new_suffix/;

    $new_suffix = ".$out_content_type.$tsv_term_name";
    $tsv_out_file_name =~ s/(\Q$old_suffix\E)?$/$new_suffix/;

    my %read_counts = ();

    open my $gff_file, '<', $gff_file_name
      or croak "can't open $gff_file_name for reading: $!\n";

    while (my $line = <$gff_file>) {
      next if $line =~ /^\s*#/;

      my @bits = split /\t/, $line;
      my $count = $bits[5];
      my $attributes = $bits[8];

      if ($attributes =~ /Name=(\w+)/) {
        my $seq = $1;
        if (exists $read_counts{$seq}) {
          if ($read_counts{$seq} != $count) {
            croak "inconsistent counts in gff file, line: $line\n";
          }
        } else {
          $read_counts{$seq} = $count;
        }
      } else {
        croak "can't find Name in gff3 line: $line\n";
      }
    }

    close $gff_file or croak "can't close $gff_file_name: $!";

    open my $fasta_out_file, '>', $fasta_out_file_name
      or die "can't open $fasta_out_file_name: $!\n";

    open my $tsv_out_file, '>', $tsv_out_file_name
      or die "can't open $tsv_out_file_name: $!\n";

    for my $sequence (sort keys %read_counts) {
      my $count = $read_counts{$sequence};

      print $fasta_out_file <<"END";
>$sequence count:$count
$sequence
END
      print $tsv_out_file "$sequence $count\n";
    }

    close $fasta_out_file or die "can't close $fasta_out_file_name: $!\n";
    close $tsv_out_file or die "can't close $tsv_out_file_name: $!\n";

    $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                          file_name => $fasta_out_file_name,
                          format_type_name => $fasta_term_name,
                          content_type_name => $out_content_type);

    $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                          file_name => $tsv_out_file_name,
                          format_type_name => $tsv_term_name,
                          content_type_name => $out_content_type);
  };
  $self->schema->txn_do($code);
}

1;

