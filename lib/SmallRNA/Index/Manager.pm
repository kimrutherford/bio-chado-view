package SmallRNA::Index::Manager;

=head1 NAME

SmallRNA::Index::Manager - Code for maintaining and searching small rna files.

=head1 SYNOPSIS

This is code for managing a indexing a GFF3 and looking up using the note.
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

=head2

 Usage   :  my $manager = $SmallRNA::Index::Manager();
            $manager->create_index(input_file_name => '...',
                                   index_file_name => '...');
 Function: Create an index from a GFF3 file, with the Name (read sequence) as
           the key
 Returns : nothing - either succeeds or calls die()

=cut
sub create_index
{
  use Bio::SeqFeature::Generic;
  my $self = shift;
  my %params = validate(@_, { input_file_name => 1,
                              index_file_name => 1 });

  my %name_hash = ();

  open my $input_file, '<', $params{input_file_name}
    or die "can't open $params{input_file_name}: $!\n";

  my $current_offset = 0;

  while (defined (my $line = <$input_file>)) {
    next if $line =~ /^#/;

    if ($line =~ /Note=([atgc]+)/i) {
      my $name = $1;
      push @{$name_hash{$name}}, $current_offset;
    } else {
      die "can't parse Note=(.*) from: $line\n";
    }
  } continue {
    $current_offset = tell $input_file;
  }

  close $input_file or die "can't close $params{input_file_name}: $!\n";

  open my $index_file, '>', $params{index_file_name}
    or die "can't open $params{index_file_name} for writing: $!\n";

  for my $name (sort keys %name_hash) {
    print $index_file "$name ", (join ',', @{$name_hash{$name}}), "\n";
  }

  close $index_file or die "can't close $params{index_file_name}: $!\n";
}

1;

