package SmallRNA::Process::RemoveAdaptersProcess;

=head1 NAME

SmallRNA::Process::RemoveAdapters - Code for removing adapters and
                                    de-muliplexing fastq sequence

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Process::RemoveAdapters

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
use Bio::SeqIO;
use Params::Validate qw(:all);
use Carp;

my $adapter  = "TCGTATGCCGTCTTCTGCTTGT";

sub _get_file_for_code
{
  my $code_out_files = shift;
  my $output_file_base = shift;
  my $code_from_seq = shift;
  my $barcodes_map_ref = shift;

  for my $code (keys %$barcodes_map_ref) {
    if ($code_from_seq eq $code) {
      if (!exists $code_out_files->{$code}) {
        my $code_name = $barcodes_map_ref->{$code};
        my $new_fasta_file_name = "${output_file_base}.$code_name.fasta";

        if (-e $new_fasta_file_name) {
          croak "won't overwrite: $new_fasta_file_name\n";
        }

        my $new_fasta_file;
        open $new_fasta_file, '>', $new_fasta_file_name
          or croak "can't open $new_fasta_file_name for writing: $!\n";
        $code_out_files->{$code} = { name => $new_fasta_file_name,
                                     file => $new_fasta_file};
      }
      return $code_out_files->{$code}{file};
    }
  }

  return undef;
}

=head2 run

 Usage   : my $res = SmallRNA::Process::RemoveAdaptersProcess->new(input_file_name => $input,
                                                                   output_dir_name => $out_dir,
                                                                   barcodes => $barcodes_map);
 Function: Remove adapters and optionally de-multiplex
 Args    : input_file_name - a fastq file name
           output_dir_name - a directory to write output files to
           barcodes - a map from barcode sequence to barcode id (TACCT => 'A',
                      TACGA => 'B', ...)

This method a two modes - multiplexed and non-multiplexed.

If there is no barcodes argument, non-multiplexed is assumed.  In that
mode run() returns a list with two element.  The first is file name
(relative to the directory given by $output_dir_name) containing the
sequences that were rejected during processing.  Reasons for rejection
include:
 - the sequence is too long (>36 bases) or short (<16 bases)
 - the sequence doesn't have a valid adapter sequence
 - the sequence contains only base, repeated

If there is a barcodes argument, run() attempts to de-multiplex while
removing the adapter.  The result in this case is a list with two
element, with the first being the name of the file with the rejected
sequences, the second being a map from barcode identifier ('A', 'B',
...) to the name of a file containing those sequences that contained
that barcode.

=cut
sub run
{
  my %params = validate(@_, { input_file_name => 1, output_dir_name => 1,
                              barcodes => 0 });

  my $input_file_name = $params{input_file_name};
  my $output_dir_name = $params{output_dir_name};
  my $barcodes_map_ref = $params{barcodes};

  my $_trim_file = sub {
    my $file_name = shift;
    if (!($file_name =~ s|^$output_dir_name/||)) {
      croak "pattern match failed for $file_name, searching for $output_dir_name/\n";
    }
    return $file_name;
  };

  my $reject_count = 0;
  my $good_sequence_count = 0;

  my $default_out_file_fasta;

  my $adapter_start;

  my $multiplexed = defined $barcodes_map_ref;

  if ($multiplexed) {
    $adapter_start = substr($adapter, 0, 3);
  } else {
    $adapter_start = substr($adapter, 0, 8);
  }

  my $output_file_base = $input_file_name;
  $output_file_base =~ s{.*/(.*?)(?:\.(?:fq|fastq))?$}{$output_dir_name/$1};

  my $fastq_seqio = Bio::SeqIO->new(-file => $input_file_name,
                                    -format => 'fastfastq');

  my $reject_file_name = "$output_file_base.rejects.fasta";

  # used when there is no multiplexing
  my $default_out_file_name = "$output_file_base.fasta";
  my $default_out_file;

  if (!$multiplexed) {
    if (-e $default_out_file_name) {
      croak "can't open $default_out_file_name for writing: file exists\n";
    }
    open $default_out_file, '>', $default_out_file_name
      or croak "can't open $default_out_file_name for writing: $!\n";
  }

  # used when there is multiplexing
  my $out_files_by_code = {};

  open my $rej_file, '>', $reject_file_name
    or croak("can't open $reject_file_name for writing: $!\n");

  my $code_re = '';
  if ($multiplexed) {
    $code_re = '(' . (join '|', keys %$barcodes_map_ref) . ')';
  }

  while (defined (my $seq_obj = $fastq_seqio->next_seq())) {
    my $sequence = $seq_obj->{sequence};
    my $seq_len = length $sequence;
    my $id = $seq_obj->{id};

    if ($sequence =~ m/^(.+)($code_re)($adapter_start.*)/) {
      my $trimmed_seq = $1;
      my $code_from_seq = $2;

      if (length $trimmed_seq < 15) {
        print $rej_file "$sequence\tIs too short ($seq_len)\n";
      } else {
        if ($trimmed_seq =~ m/^([ACGT]+$)/i) { # i.e. has no Ns
          if ($multiplexed) {
            if (length $trimmed_seq == 0) {
              print $rej_file "$sequence\tNo sequence after removing bar code $code_from_seq\n";
            } else {
              if (length $trimmed_seq > 0) {
                my $out_file_fasta = _get_file_for_code($out_files_by_code,
                                                        $output_file_base,
                                                        $code_from_seq,
                                                        $barcodes_map_ref);

                if (defined $out_file_fasta) {
                  print $out_file_fasta ">$id\n";
                  print $out_file_fasta "$trimmed_seq\n";
                  $good_sequence_count++;
                } else {
                  print $rej_file "$sequence\tDoes not match any barcodes, code: \t$code_from_seq\n";
                }

              } else {
                print $rej_file "$sequence\tIs zero length after removing the adapter and bar code ($code_from_seq)\n";
              }
            }
          } else {
            print $default_out_file ">$id\n";
            print $default_out_file "$trimmed_seq\n";
            $good_sequence_count++;
          }
        } else {
          $reject_count++;
          print $rej_file "$sequence\tContains Ns\n";
        }
      }
    } else {
      $reject_count++;
      print $rej_file "$sequence\tDoes not match (seq)(adapter)\n";
    }

    if ($ENV{'SMALLRNA_PIPELINE_TEST'} &&
          ($good_sequence_count > 10000 || $reject_count > 10000)) {
      last;
    }
  }

  if (defined $default_out_file) {
    close $default_out_file or croak "can't close $default_out_file_name: $!\n";
  }

  for my $barcode_file (values %$out_files_by_code) {
    close $barcode_file->{file} or croak "can't close file: $!\n";
  }

  if ($multiplexed) {
    return ($_trim_file->($reject_file_name), {map {
      ($_ => $_trim_file->($out_files_by_code->{$_}{name}))
    } keys %$out_files_by_code});
  } else {
    return ($_trim_file->($reject_file_name),
            $_trim_file->($default_out_file_name));
  }
}

1;
