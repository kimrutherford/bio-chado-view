package SmallRNA::Process::FirstBaseCompSummary;

=head1 NAME

SmallRNA::Process::FirstBaseCompSummary - Summarise a fasta file of short sequences

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Process::FirstBaseCompSummary

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
use Bio::SeqIO;
use Params::Validate qw(:all);
use warnings;

my $MIN_SIZE = 15;
my @BASES = qw(a c g t);
my $LINE_FORMAT = "%-6s%8d %8d %8d %8d %8d  %6.2f %6.2f %6.2f %6.2f\n";

sub _write_line
{
  my $out = shift;
  my $len = shift;
  my $base_stats_ref = shift;
  my $total = shift;

  my @base_stats = map {
    if (exists $base_stats_ref->{$_}) {
      $base_stats_ref->{$_}
    } else {
      0
    }
  } @BASES;

  my @percent_base_stats;

  if ($total > 0) {
    @percent_base_stats = map { 100.0 * $_ / $total; } @base_stats;
  } else {
    @percent_base_stats = @base_stats;
  }

  printf $out ($LINE_FORMAT, $len,
               @base_stats,
               $total,
               @percent_base_stats);
}

=head2

 Usage   : SmallRNA::Process::FirstBaseCompSummary::run(input_file_name =>
                                                          $in_file_name,
                                                        output_file_name =>
                                                          $out_file_name);
 Function: Create a summary of the first bases of the reads in the input file.
 Args    : input_file_name - the input file name of small rna reads
           output_file_name - the name of the file to write the summary to
 Returns : nothing - either succeeds or calls die()

=cut

sub run
{
  my %params = validate(@_, { input_file_name => 1, output_file_name => 0 });

  my @first_base_stats = ();
  my @length_counts = ();
  my @composition_stats = ();
  my %all_composition_stats = ();

  my $all_count = 0;
  my $big_seq_count = 0;

  if (!-e $params{input_file_name}) {
    croak "can't find input file: $params{input_file_name}";
  }

  my $in = Bio::SeqIO->new(-file => $params{input_file_name},
                           -format => 'Fasta');

  while (defined (my $seq = $in->next_seq())) {
    my $sequence = $seq->seq();

    if ($ENV{'SMALLRNA_PIPELINE_TEST'} && $all_count > 100) {
      last;
    }

    $all_count++;

    if (length $sequence < $MIN_SIZE) {
      next;
    }

    $big_seq_count++;

    my $first_base = substr $sequence, 0, 1;

    $first_base_stats[length $sequence]{lc $first_base}++;
    $length_counts[length $sequence]++;

    for (my $i = 0; $i < length $sequence; $i++) {
      my $bit = substr $sequence, $i, 1;
      $composition_stats[length $sequence]{$bit}++;
      $all_composition_stats{$bit}++;
    }
  }

  if (defined $params{output_file_name}) {
    open my $out, '>', $params{output_file_name}
    or die "can't open $params{output_file_name} for writing: $!\n";

    print $out <<"HEAD";
File: $params{input_file_name}
Total number of sequences: $all_count
Sequences >= $MIN_SIZE: $all_count

Length    First base composition:
             A        C        G        T      Any      \%A     \%C     \%G     \%T
HEAD


    for (my $i = 0; $i < @length_counts; $i++) {
      if (defined $length_counts[$i] and $length_counts[$i] > 0) {
        _write_line $out, $i, $first_base_stats[$i], $length_counts[$i];
      }
    }

    _write_line $out, 'all', \%all_composition_stats, $all_count;

    close $out or die "can't close $params{output_file_name}: $!\n";
  }

  # this is for testing the stats
  return { count => \@length_counts, first_base_counts => \@first_base_stats };
}

1;
