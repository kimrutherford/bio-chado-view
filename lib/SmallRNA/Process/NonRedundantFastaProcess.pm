package SmallRNA::Process::NonRedundantFastaProcess;

=head1 NAME

SmallRNA::Process::NonRedundantFastaProcess - Create a non redundant FASTA file

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Process::NonRedundantFastaProcess

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

use Params::Validate qw(:all);

use Bio::SeqIO;

=head2
 
 Usage   : SmallRNA::Process::NonRedundantFastaProcess(input_file_name =>
                                                         $in_file_name,
                                                       output_file_name =>
                                                         $out_file_name);
 Function: Create a non-redundant FASTA file from the input.  The records in
           the output file will have a count:<num> in the header to show how
           many times the read/sequence occurs in the input.
 Args    : input_file_name - the input file name of sequences in FASTA format
           output_file_name - the name of the file to write the non-redundant
                              sequences to
 Returns : nothing - either succeeds or calls die()

=cut
sub run
{
  my %params = validate(@_, { input_file_name => 1,
                              output_file_name => 1,
                            });

  my $input_file_name = $params{input_file_name};
  my $output_file_name = $params{output_file_name};

  my $seqio = Bio::SeqIO->new(-file => $params{input_file_name} ,
                              -format => 'Fasta');

  my %fasta_counts = ();

  while (my $seq = $seqio->next_seq()) {
    $fasta_counts{$seq->seq()}++;
  }

  open my $outfile, '>', $output_file_name
    or die "can't open $output_file_name: $!\n";

  for my $key (sort keys %fasta_counts) {
    my $count = $fasta_counts{$key};
    print $outfile <<"END";
>$key count:$count
$key
END
  }

  close $outfile or die "can't close $output_file_name: $!\n";
}

1;

