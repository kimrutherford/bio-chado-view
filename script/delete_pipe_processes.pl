#!/usr/bin/perl -w

use strict;
use warnings;
use Carp;

use SmallRNA::DB;
use SmallRNA::Web;

die "needs one argument, a pipeprocess type name" unless @ARGV == 2;

my $delete_type = shift;

my $c = SmallRNA::Web->commandline();
my $config = $c->config();

my $schema = SmallRNA::DB->schema($config);

my $rs = $schema->resultset('Pipeprocess');

while (defined (my $pipeprocess = $rs->next())) {
  if ($pipeprocess->process_conf()->name() eq $delete_type) {
    
  }
}
