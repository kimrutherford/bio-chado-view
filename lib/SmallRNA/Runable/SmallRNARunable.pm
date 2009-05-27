package SmallRNA::Runable::SmallRNARunable;

=head1 NAME

SmallRNA::Runable::SmallRNARunable - A RunableI specialised for the SmallRNA
                                     pipeline

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Runable::SmallRNARunable

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
use warnings;
use Moose;
use Carp;
use File::Path;
use Params::Validate qw(:all);

with 'SmallRNA::RunableI';

has 'schema' => (is => 'ro', isa => 'SmallRNA::DB', required => 1);
has 'config' => (is => 'ro', required => 1);
has 'pipeprocess' => (is => 'ro', isa => 'SmallRNA::DB::Pipeprocess',
                      required => 1);

sub input_files
{
  my $self = shift;

  my @ret_files = ();
  my $process = $self->pipeprocess();
  my @input_pipedatas = $process->input_pipedatas();

  for my $pipedata (@input_pipedatas) {
    push @ret_files, $pipedata->file_name();
  }

  return @ret_files;
}

=head2

 Function: Store a file name in the pipedata table.
 Args    : generating_pipeprocess - the pipeprocess object that represents the
             process that generated this file; stored in the pipedata object
           file_name - the file to add
           format_type_name - the cvterm name of the format of the file
           content_type_name - the cvterm name of the content type of the file
           samples - a list of the sample(s) that this pipedata comes from, or
             empty list if we should use the samples from the input pipedata
             for the generating_pipeprocess
 Returns : nothing - either succeeds or calls die()

=cut
sub store_pipedata
{
  my $self = shift;

  my %params = validate(@_, { generating_pipeprocess => 1,
                              file_name => 1,
                              format_type_name => 1,
                              content_type_name => 1,
                              samples => 0
                            });

  my $schema = $self->schema();

  my $format_term =
    $schema->find_with_type('Cvterm', name => $params{format_type_name});
  my $content_term =
    $schema->find_with_type('Cvterm', name => $params{content_type_name});

  my $file_name = $params{file_name};

  my $data_dir = $self->config()->data_directory();

  $file_name =~ s|$data_dir/*||;

  my $full_file_name = "$data_dir/$file_name";

  if (!-e $full_file_name) {
    croak "error: tried to store a file that doesn't exist: $file_name\n";
  }

  my $file_length = -s $full_file_name;

  my $pipedata_args = {
                       generating_pipeprocess => $params{generating_pipeprocess},
                       file_name => $file_name,
                       format_type => $format_term,
                       content_type => $content_term,
                       file_length => $full_file_name,
                      };
  my $pipedata = $schema->create_with_type('Pipedata', $pipedata_args);

  if (defined $params{samples}) {
    if (@{$params{samples}} > 0) {
      $pipedata->add_to_samples(@{$params{samples}});
      $pipedata->update();
    }
  } else {
    my @prev_pipedata =
      $params{generating_pipeprocess}->pipeprocess_in_pipedatas()->search_related('pipedata');
    my @prev_samples = map { $_->samples() } @prev_pipedata;
    $pipedata->add_to_samples(@prev_samples);
  }

  return $pipedata;
}

sub run
{
  croak "you must implement this method\n";
}

1;
