package ChadoView::Index::Manager;

=head1 NAME

ChadoView::Index::Manager - Code for maintaining and searching small rna files.

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

    perldoc ChadoView::Index::Manager

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
use DB_File;

=head2

 Usage   :  my $manager = $ChadoView::Index::Manager();
            $manager->create_index(input_file_name => '...',
                                   index_file_name => '...',
                                   input_file_type => 'gff3',
                                   index_type => 'dbm');
 Function: Create an index from a GFF3 or FASTA file, with the sequence as
           the key
 Args    : input_file_name - the file to index
           index_file_name - the name of the index file to create
           input_file_type - 'gff3' or 'fasta'
           index_type - the type of the index to create, either dbd (default)
                        or sorted
 Returns : nothing - either succeeds or calls croak()

=cut
sub create_index
{
  my $self = shift;
  my %params = validate(@_, { input_file_name => 1,
                              index_file_name => 1,
                              input_file_type => 1,
                              index_type => 0 });

  my %name_hash = ();

  my $index_type = $params{index_type} || 'dbm';

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

  if ($index_type eq 'dbm') {
    tie my %disk_hash, 'DB_File',
      $params{index_file_name}, O_RDWR|O_CREAT, 0666;

    for my $name (sort keys %name_hash) {
      $disk_hash{$name} = join ',', @{$name_hash{$name}};
    }

    untie %disk_hash;
  } else {
    if ($params{index_type} eq 'sorted') {
      open my $index_file, '>', $params{index_file_name}
        or croak "can't open $params{index_file_name} for writing: $!\n";

      for my $name (sort keys %name_hash) {
        print $index_file "$name ", (join ',', @{$name_hash{$name}}), "\n";
      }

      close $index_file or croak "can't close $params{index_file_name}: $!\n";
    } else {
      croak "unknown index type: $params{index_type}\n"
    }
  }
}

sub _get_offsets_sorted
{
  my $index_file_name = shift;
  my $search_sequence = shift;

  open my $index_file, '<', $index_file_name
    or croak "can't open $index_file_name: $!\n";

  my $look = look $index_file, uc $search_sequence;

  if (defined $look) {
    seek $index_file, $look, SEEK_SET
      or croak "can't seek to $look in $index_file_name";

    my $line = <$index_file>;

    close $index_file or croak "can't close $index_file_name: $!\n";

    if (defined $line) {
      my ($seq, $offsets_string) = split (/\s+/, $line);

      if ($seq eq $search_sequence) {
        return split (/,/, $offsets_string);
      } else {
        # not an exact match
      }
    } else {
      # empty index file / empty GFF file
    }
  } else {
    # no results
  }

  return ();
}

sub _get_offsets_dbm
{
  my $index_file_name = shift;
  my $search_sequence = shift;

  my %disk_hash;

  if (!defined tie %disk_hash, 'DB_File', $index_file_name, O_RDWR, 0666) {
    die "can't tie() $index_file_name: $!\n";
  }

  my $val = $disk_hash{uc $search_sequence};

  untie %disk_hash;

  if (defined $val) {
    return split /,/, $val;
  } else {
    return ();
  }
}

=head2

 Usage   : my @lines = $manager->search(input_file_name => '...',
                                        index_file_name => '...',
                                        search_sequence => 'ATGC...');
 Function: Use an index to search a gff3 or FASTA for records that match the
           given sequence.  The index is created by the
           ChadoView::Index::Manager::create_index() function.
 Args    : input_file_name - the name of the file to search
           index_file_name - the name of the index file to use
           search_sequence - the sequence to search for
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

  my @offsets;

  if (-T $params{index_file_name}) {
    @offsets = _get_offsets_sorted($params{index_file_name}, $search_sequence);
  } else {
    @offsets = _get_offsets_dbm($params{index_file_name}, $search_sequence);
  }

  open my $input_file, '<', $params{input_file_name}
    or croak "can't open $params{input_file_name}: $!\n";

  for my $offset (@offsets) {
    seek $input_file, $offset, SEEK_SET
        or croak "can't seek to $offset in $params{input_file_name}";

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

  return @results;
}

1;
