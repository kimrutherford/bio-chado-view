#!/usr/bin/perl -w

use strict;

use warnings;

use DateTime;

use SmallRNA::Config;
use SmallRNA::DB;
use SmallRNA::DBLayer::Loader;

if (@ARGV != 3) {
  die <<"EOF";
error: needs three arguments

usage:
  $0 <sequencing_centre_short_name> <sample_identifier> <sequencing_run_identifier>
EOF
}

my $connect_string = SmallRNA::Config->db_connect_string();

my $username = SmallRNA::Config->db_username();
my $password = SmallRNA::Config->db_password();

my $schema = SmallRNA::DB->connect($connect_string, $username, $password);

my $sequencingcentre_short_name = shift;
my $sample_identifier = shift;
my $sequencing_run_identifier = shift;

my $sample_rs = $schema->resultset('Sample');
my $sample = $sample_rs->find({
                               name => $sample_identifier
                              });

if (!defined $sample) {
  die "couldn't find sample with name: $sample_identifier\n";
}

my $sequencingtype = $schema->find_with_type('Cvterm', 'name', 'Illumina');

my $sequencingcentre = $schema->find_with_type('Organisation', 'name',
                                               $sequencingcentre_short_name);

my $sequencing_rs = $schema->resultset('Sequencingrun');

$sequencing_rs->create({
                        identifier => $sequencing_run_identifier,
                        sample => $sample,
                        submissiondate => DateTime->now(),
                        sequencingtype => $sequencingtype,
                        sequencingcentre => $sequencingcentre
                       });
