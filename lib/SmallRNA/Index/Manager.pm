package SmallRNA::Index::Manager;

=head1 NAME

SmallRNA::Index::Manager - Code for maintaining and searching small rna files.

=head1 SYNOPSIS

This is code for indexing GFF3 or FASTA files and looking up using a sequence.
The format of the index file is:
 <sequence> <offset1>,<offset2>...
sorted by the <sequence> column.

When indexing GFF3, the sequence comes from the Note attribute.

The offsets are byte offsets into the GFF3 or FASTA file.  The offsets
are the starts of the lines that have that sequence.

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Index::Manager

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

use Params::Validate qw(:all);

use Search::Dict;
use POSIX;

=head2

 Usage   :  my $manager = $SmallRNA::Index::Manager();
            $manager->create_index(input_file_name => '...',
                                   index_file_name => '...',
                                   input_file_type => 'gff3');
 Function: Create an index from a GFF3 or FASTA file, with the sequence as
           the key
 Args    : input_file_name - the file to index
           index_file_name - the name of the index file to create
           input_file_type - 'gff3' or 'fasta'
 Returns : nothing - either succeeds or calls croak()

=cut
sub create_index
{
  my $self = shift;
  my %params = validate(@_, { input_file_name => 1,
                              index_file_name => 1,
                              input_file_type => 1 });

  my %name_hash = ();

  open my $input_file, '<', $params{input_file_name}
    or croak "can't open $params{input_file_name}: $!\n";

  my $current_offset = 0;

  my $re;

  if (lc $params{input_file_type} eq 'gff3') {
    $re = qr{Note=([atgc]+)}i;
  } else {
    if (lc $params{input_file_type} eq 'fasta') {
      $re = qr{^>([atgc]+)}i;
    } else {
      croak "unknown type $params{input_file_type}\n";
    }
  }

  while (defined (my $line = <$input_file>)) {
    next if $line =~ /^#|^[atgc]+$/i;

    if ($line =~ $re) {
      my $name = $1;
      push @{$name_hash{uc $name}}, $current_offset;
    } else {
      croak "can't parse sequence from: $line\n";
    }
  } continue {
    $current_offset = tell $input_file;
  }

  close $input_file or croak "can't close $params{input_file_name}: $!\n";

  open my $index_file, '>', $params{index_file_name}
    or croak "can't open $params{index_file_name} for writing: $!\n";

  for my $name (sort keys %name_hash) {
    print $index_file "$name ", (join ',', @{$name_hash{$name}}), "\n";
  }

  close $index_file or croak "can't close $params{index_file_name}: $!\n";
}

=head2

 Usage   : my @lines = $manager->search(input_file_name => '...',
                                        index_file_name => '...',
                                        search_sequence => 'ATGC...');
 Function: Use an index to search a gff3 or FASTA for records that match the
           given sequence.  The index is created by the
           SmallRNA::Index::Manager::create_index() function.
 Returns : The lines from the file.  For FASTA, just the header line is returned

=cut
sub search
{
  my $self = shift;
  my %params = validate(@_, { input_file_name => 1,
                              index_file_name => 1,
                              search_sequence => 1 });

  my $search_sequence = uc $params{search_sequence};

  my @results = ();

  open my $index_file, '<', $params{index_file_name}
    or croak "can't open $params{index_file_name}: $!\n";

  my $look = look $index_file, uc $search_sequence;

  if (defined $look) {
    seek $index_file, $look, SEEK_SET
      or croak "can't seek to $look in $params{index_file_name}";

    my $line = <$index_file>;

    if (defined $line) {
      my ($seq, $offsets_string) = split (/\s+/, $line);

      if ($seq eq $search_sequence) {
        my @offsets = split (/,/, $offsets_string);

        open my $input_file, '<', $params{input_file_name}
          or croak "can't open $params{input_file_name}: $!\n";

        for my $offset (@offsets) {
          seek $input_file, $offset, SEEK_SET
            or croak "can't seek to $look in $params{input_file_name}";

          my $input_line = <$input_file>;

          chomp $input_line;

          # sanity check
          if ($input_line =~ /Note=$search_sequence\b|>$search_sequence\b/) {
            push @results, $input_line;
          } else {
            croak "index doesn't match GFF file: $params{search_sequence} not " .
              "found at line: $input_line\n";
          }
        }

        close $input_file or croak "can't close $params{input_file_name}: $!\n";
      } else {
        # empty index file / empty GFF file
      }
    } else {
      # not an exact match
    }
  } else {
    # no results
  }

  close $index_file or croak "can't close $params{index_file_name}: $!\n";

  return @results;
}


1;
