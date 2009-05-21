use strict;
use warnings;
use Test::More tests => 7;

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Runable::SmallRNARunable';
}

use SmallRNA::Config;
use SmallRNA::DB;
use SmallRNA::ProcessManager;
use SmallRNATest;

my $config = SmallRNA::Config->new('t/test_config.yaml');

my $schema = SmallRNA::DB->schema($config);

SmallRNATest::setup($schema, $config);

my $conf_manager = SmallRNA::ProcessManager->new(schema => $schema);

my @processes = $conf_manager->create_new_pipeprocesses();

is(scalar(@processes), 4, 'pipeprocess count');
my $process = $processes[0];
ok(defined $process);

my $pipedata_rs = $schema->resultset('Pipedata')->search();

while (my $pipedata = $pipedata_rs->next()) {
  if ($pipedata->file_name() =~ /SL236/) {
    ok(scalar($pipedata->next_pipeprocesses()) == 1);
    ok(($pipedata->next_pipeprocesses())[0]->description() eq
         'processing with conf: remove adapters');
  } else {
    if ($pipedata->file_name() =~ /SL234/) {
      ok(scalar($pipedata->next_pipeprocesses()) == 1);
      ok(($pipedata->next_pipeprocesses())[0]->description() eq
           'processing with conf: remove adapters and de-multiplex');
    }
  }
}
