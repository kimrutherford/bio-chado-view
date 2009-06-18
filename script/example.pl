#!/usr/bin/perl -w

use strict;
use warnings;

BEGIN {
  push @INC, "lib";
}

use ChadoView::Config;
use ChadoView::DB;

my $config = ChadoView::Config->new('chadoview_web.yaml');
my $schema = ChadoView::DB->schema($config);

my $rs = $schema->resultset('Cvterm');

while (defined (my $cvterm = $rs->next())) {
  print $cvterm->name(), ' ', $cvterm->cv()->name(), "\n";
}
