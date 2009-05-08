#!/usr/bin/perl -w

# recreate the DB classes by reading the database schema

BEGIN {
  push @INC, "lib";
}

use strict;

use SmallRNA::Web;

my $c = SmallRNA::Web->commandline();
my $config = $c->config();

my @connect_info = @{$config->{"Model::SmallRNAModel"}{connect_info}};

my ($connect_string, $username, $password) = @connect_info;

use DBIx::Class::Schema::Loader qw(make_schema_at);

make_schema_at('SmallRNA::DB',
               { debug => 1, dump_directory => './lib' },
               [ "$connect_string;password=$password", $username ]);


