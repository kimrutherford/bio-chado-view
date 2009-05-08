#!/usr/bin/perl -w

use strict;

use warnings;

use Getopt::Long;

use SmallRNA::Config;
use SmallRNA::DB;
use SmallRNA::DBLayer::Loader;

my $barcode_id;

GetOptions("barcode-id=s" => \$barcode_id);

if (@ARGV != 2) {
  die <<"EOF";
error: needs two arguments

usage:
  $0 [--barcode-id <barcode_id>] <project_name> <sample_identifier>
EOF
}

my $connect_string = SmallRNA::Config->db_connect_string();

my $username = SmallRNA::Config->db_username();
my $password = SmallRNA::Config->db_password();

my $schema = SmallRNA::DB->connect($connect_string, $username, $password);

my $project_name = shift;
my $sample_identifier = shift;

my $project_rs = $schema->resultset('Seqproject');
my $project = $project_rs->find({
                                 name => $project_name
                                });

my $rna_molecule_type = $schema->find_with_type('Cvterm', name => 'RNA');

if (!defined $project) {
  die "couldn't find project with name: $project_name\n";
}

my $barcode = undef;

if (defined $barcode_id) {
  my $barcode_rs = $schema->resultset('Barcode');
  $barcode = $barcode_rs->find({
                                identifier => $barcode_id
                               });

  if (!defined $barcode) {
    die "couldn't find barcode with name: $barcode_id\n";
  }
}

my $sample_rs = $schema->resultset('Sample');

my %args = (
            name => $sample_identifier,
            seqproject => $project,
            molecule_type => $rna_molecule_type
           );

if (defined $barcode) {
  $args{barcode} = $barcode;

}

$sample_rs->create(\%args);
