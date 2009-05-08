#!/usr/bin/perl -w

use strict;

use Getopt::Std;

use SmallRNA::Config;
use SmallRNA::Tracking::Track;
use SmallRNA::DB;

my %opts = ();

getopt('oDI', \%opts);

# called when user passes --help
sub HELP_MESSAGE
{
  my $message = shift;

  die <<"EOF";
$message

Usage:
  $0 <fastq_file_name> [<fastq_file_name> ...]

This script will create a new project directory, copy the fastq file to the
new directory then register the file with the tracking database.
EOF
}

if (@ARGV < 1) {
  HELP_MESSAGE("needs at lease one argument");
}

my $connect_string = SmallRNA::Config->db_connect_string();

my $username = SmallRNA::Config->db_username();
my $password = SmallRNA::Config->db_password();

my $schema = SmallRNA::DB->connect($connect_string, $username, $password);

my $track = SmallRNA::Tracking::Track->new(schema => $schema);

for my $arg (@ARGV) {
  $track->add_new_data(fastq_file_name => $arg);
}
