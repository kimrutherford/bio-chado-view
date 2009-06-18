#!/usr/bin/perl

# recreate the DB classes by reading the database schema

BEGIN {
  push @INC, "lib";
}

use strict;
use warnings;

use ChadoView::Web;

my $c = ChadoView::Web->commandline();
my $config = $c->config();

my @connect_info = @{$config->{"Model::ChadoViewModel"}{connect_info}};

my ($connect_string, $username, $password) = @connect_info;

use DBIx::Class::Schema::Loader qw(make_schema_at);

# change the methods on the objects so we can say $person->organisation()
# rather than $person->organisation_id() to get the Organisation
sub remove_id {
  my $relname = shift;
  my $res = Lingua::EN::Inflect::Number::to_S($relname);
  $res =~ s/_id$//;
  return $res;
}

make_schema_at('ChadoView::DB',
               { debug => 1, dump_directory => './lib', inflect_singular =>
                 \&remove_id },
               [ "$connect_string;password=$password", $username ]);
