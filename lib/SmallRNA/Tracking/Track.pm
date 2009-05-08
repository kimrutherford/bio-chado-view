package SmallRNA::Tracking::Track;

=head1 NAME

SmallRNA::Tracking::Track - Code for tracking analysis files

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Tracking::Track

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
use SmallRNA::Config;
use File::Path;
use Params::Validate qw(:all);
use File::Copy;

=head2 new

 Usage   : my $loader = SmallRNA::Tracking::Track(schema => $schema);
 Function: Return a helper object for loading into the database
 Args    : a SmallRNA::DB schema

=cut
sub new
{
  my $class = shift;
  my %params = validate(@_, { schema => 1 });
  my $self = {};

  $self->{schema} = $params{schema};
  return bless $self, $class;
}

=head2 add_new_data

 Usage   : $track->add_new_data(fastq_file_name => $filename);
 Function: Add a new input file to the tracking system.  The type is guessed
           based on the extension.  The sequencingrun identifier is extracted
           from the filename
 Args    : none

=cut
sub add_new_data
{
  my $self = shift;
  my %params = validate(@_, { fastq_file_name => 1 });

  my $fastq_file_name = $params{fastq_file_name};

  if (!-e $fastq_file_name) {
    croak "error: $fastq_file_name doesn't exist\n";
  }

  if ($fastq_file_name =~ m|^.*/(([^.]+)\..*\.fq)$|) {
    my $basename = $1;
    my $run_id = $2;

    my $file_type = 'fastq';

    my $sequencingrun_rs = $self->{schema}->resultset('Sequencingrun');
    my $sequencingrun = $sequencingrun_rs->find({
                                                 identifier => $run_id
                                                });

    if (!defined $sequencingrun) {
      $sequencingrun = $sequencingrun_rs->find({
                                                identifier => $run_id . "_run"
                                               });

      if (!defined $sequencingrun) {
        croak "couldn't find a sequencingrun with identifier: $run_id\n";
      }
    }

    if (defined $sequencingrun->seqdatafile()) {
      croak ("error: a $file_type file has already been registered for $run_id: " .
             $sequencingrun->seqdatafile()->filename());
    }

    my $datafile_rs = $self->{schema}->resultset('Seqdatafile');
    my $existing_datafile = $datafile_rs->find({filename => $basename});

    if (defined $existing_datafile) {
      croak ("a seqdatafile is already registered for sequencing run $run_id, "
             . "with filename: " . $existing_datafile->filename());
    }

    my $data_dir = SmallRNA::Config->data_directory();

    my $fastq_dir = "$data_dir/$file_type";

    mkpath($fastq_dir);

    my $dest_file = "$fastq_dir/$basename";

    if (-e $dest_file) {
      croak "error: destination file already exists: $dest_file\n";
    }

    print "found sequencing run for $basename - copying to $fastq_dir\n";

    open my $out, '>', $dest_file;

#    copy($fastq_file_name, $fastq_dir);

    my $seqanalysis =
       $self->{schema}->find_with_type('Seqanalysis', 'description',
                                       'CRI sequencing run');

    my $file_type_cvterm =
      $self->{schema}->find_with_type('Cvterm', 'name', $file_type);

    my $txn_code = sub {
      my $new_datafile = $datafile_rs->create({ filename => $basename,
                                                seqanalysis => $seqanalysis,
                                                type => $file_type_cvterm });
      $sequencingrun->seqdatafile($new_datafile);
      $sequencingrun->update();
    };

    $self->{schema}->txn_do($txn_code);

  } else {
    croak "filename not in the expected format: <runid>.<other_stuff>.fq\n";
  }

}

1;
