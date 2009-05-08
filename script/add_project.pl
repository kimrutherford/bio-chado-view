#!/usr/bin/perl -w

use strict;

use warnings;

use SmallRNA::Config;
use SmallRNA::DB;
use SmallRNA::DBLayer::Loader;

my $connect_string = SmallRNA::Config->db_connect_string();

my $username = SmallRNA::Config->db_username();
my $password = SmallRNA::Config->db_password();

my $schema = SmallRNA::DB->connect($connect_string, $username, $password);

my $person_name = ucfirst shift;
my $project_name = shift;
my $project_desc = shift;

my $person_rs = $schema->resultset('Person');
my $person;

if ($person_name =~ /(.*)[_ ](.*)/) {
  $person = $person_rs->find({
                              first_name => $1,
                              last_name => ucfirst $2
                             }, { key => 'person_full_name_constraint' });

  if (!defined $person) {
    die "couldn't find person with name: $1 $2\n";
  }
} else {
  my @people = $person_rs->search([{
                                   first_name => $person_name
                                  },
                                  {
                                   last_name => $person_name
                                  }]);
  if (@people == 1) {
    $person = $people[0];
  } else {
    if (@people == 0) {
      die "no person found in database with name: $person_name\n";
    } else {
      my $names = join ', ', map { $_->first_name() . $_->last_name() } @people;
      die "more than one person found in database with name: $person_name\n";
    }
  }
}

my $project_type = $schema->find_with_type('Cvterm', 'name',
                                           'small RNA sequencing');

my $seqproject_rs = $schema->resultset('Seqproject');

$seqproject_rs->create({
                        name => $project_name,
                        description => $project_desc,
                        owner => $person,
                        type => $project_type
                       });
