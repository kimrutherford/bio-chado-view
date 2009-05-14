package SmallRNA::Index::Manager;

=head1 NAME

SmallRNA::Index::Manager - Code for maintaining and searching small rna files.

=head1 SYNOPSIS

 my $manager = $SmallRNA::Index::Manager();

 $manager->create_index(input_file_name => $in_file_name,
                        index_file_name => 

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

sub create_index
{
  use Bio::SeqFeature::Generic;
  my $self = shift;
  my %params = validate(@_, { input_file_name => 1,
                              index_file_name => 1 });

  my %id_hash = ();

  open my $input_file, '<', $params{input_file_name}
    or die "can't open $params{input_file_name}: $!\n";

  while (defined (my $line = <$input_file>)) {
    next if $line =~ /^#/;

    if ($line =~ /ID=([atgc]+)/i) {
      my $id = $1;
      push @{$id_hash{$id}}, tell $input_file;
    } else {
      die "can't parse ID=(.*) from: $line\n";
    }
  }
  
  close $input_file or die "can't close $params{input_file_name}: $!\n";

  open my $index_file, '>', $params{index_file_name}
    or die "can't open $params{index_file_name} for writing: $!\n";

  for my $id (sort keys %id_hash) {
    print $index_file "$id ", (join ',', @{$id_hash{$id}}), "\n";
  }

  close $index_file or die "can't close $params{index_file_name}: $!\n";
}

1;

