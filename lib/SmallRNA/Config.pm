package SmallRNA::Config;

=head1 NAME

SmallRNA::Config - Configuration information for SmallRNA Perl code

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Config

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

use Params::Validate qw(:all);
use YAML qw(LoadFile);
use Carp;

my @config_dirs = ('.', $ENV{HOME}, '/etc/');
my $default_file_name = 'smallrna_web.yaml';

=head2 new

 Usage   : my $config = SmallRNA::Config->new($file_name);
       or: my $config = SmallRNA::Config->new();
 Function: Create a new Config object from the file.  If no config_file_name is
           given look in the current directory, $HOME and /etc/

=cut
sub new
{
  my $class = shift;
  my $config_file_name = shift;

  my $self;

  if (!defined $config_file_name) {
    for my $dir (@config_dirs) {
      my $full_path = "$dir/$default_file_name";
      if (-e $full_path) {
        $config_file_name = $full_path;
      }
    }
  }

  if (!defined $config_file_name) {
    $self = LoadFile($config_file_name);
  } else {
    croak "can't find config file: $config_file_name in @config_dirs\n";
  }

  bless $self, $class;

  $self->setup();

  return $self;
}

=head2 setup

 Usage   : $config->setup();
 Function: perform initialisation for this object

=cut
sub setup
{
  my $self = shift;

  my %field_info_hash = ();

  for my $class_name (keys %{$self->{class_info}}) {
    my $class_info = $self->{class_info}->{$class_name};
    for my $field_info (@{$class_info->{field_info_list}}) {
      my $field_label = $field_info->{field_label};
      $self->{class_info}->{$class_name}->{field_infos}->{$field_label} =
        $field_info;
    }
  }
}

=head2 data_directory

 Usage   : my $dir = SmallRNA::Config->data_directory();
 Function: Return the directory for storing pipeline data
 Args    : none

=cut
sub data_directory
{
  my $self = shift;
  return $self->{pipeline_directory} . '/process';
}

1;
