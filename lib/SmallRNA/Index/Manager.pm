package SmallRNA::Index::Manager;

=head1 NAME

SmallRNA::Index::Manager - Code for maintaining and searching small rna files.

=head1 SYNOPSIS

This is code for managing and indexing a GFF3 and looking up using the sequence.
The format of the index file is:
 <note> <offset1>,<offset2>...
sorted by the <note> column.

The note is the Note field from the GFF3 file and offset1... are byte offsets
into the GFF3 file.  The offsets are the starts of the lines that have that
name as the Note.

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
                                   index_file_name => '...');
 Function: Create an index from a GFF3 file, with the Name (read sequence) as
           the key
 Returns : nothing - either succeeds or calls croak()

=cut
sub create_index
{
  my $self = shift;
  my %params = validate(@_, { input_file_name => 1,
                              index_file_name => 1 });

  my %name_hash = ();

  open my $input_file, '<', $params{input_file_name}
    or croak "can't open $params{input_file_name}: $!\n";

  my $current_offset = 0;

  while (defined (my $line = <$input_file>)) {
    next if $line =~ /^#/;

    if ($line =~ /Note=([atgc]+)/i) {
      my $name = $1;
      push @{$name_hash{uc $name}}, $current_offset;
    } else {
      croak "can't parse Note=(.*) from: $line\n";
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

 Usage   : my @gff_lines = $manager->search(gff_file_name => '...',
                                            index_file_name => '...',
                                            search_sequence => 'ATGC...');
 Function: Use an index to search a gff3 file lines that have a Note containing
           the given sequence.  The index is created by the
           SmallRNA::Index::Manager::create_index() function.
 Returns : The lines from the GFF3 file

=cut
sub search
{
  my $self = shift;
  my %params = validate(@_, { gff_file_name => 1,
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

        open my $gff_file, '<', $params{gff_file_name}
          or croak "can't open $params{gff_file_name}: $!\n";

        for my $offset (@offsets) {
          seek $gff_file, $offset, SEEK_SET
            or croak "can't seek to $look in $params{gff_file_name}";

          my $gff_line = <$gff_file>;

          # sanity check
          if ($gff_line =~ /Note=$search_sequence\b/) {
            push @results, $gff_line;
          } else {
            croak "index doesn't match GFF file: $params{search_sequence} not " .
              "found at line: $gff_line\n";
          }
        }

        close $gff_file or croak "can't close $params{gff_file_name}: $!\n";
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
