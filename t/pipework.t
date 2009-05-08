use strict;
use warnings;
use Test::More tests => 17;
use DateTime;

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Runable::SmallRNARunable';
}

use SmallRNA::Config;
use SmallRNA::DB;
use SmallRNA::ProcessManager;
use SmallRNATest;
use SmallRNA::Runable::RemoveAdaptersRunable;
use SmallRNA::PipeWork;

my $config = SmallRNA::Config->new('t/test_config.yaml');

my $schema = SmallRNA::DB->schema($config);

# create database and test directories
SmallRNATest::setup($schema, $config);

my $process_manager = SmallRNA::ProcessManager->new(schema => $schema);

my $queued_status = $schema->find_with_type('Cvterm', name => 'queued');
my $started_status = $schema->find_with_type('Cvterm', name => 'started');

for (my $i = 0; $i < 4; $i++) {
  # this is a faked version of pipeserv.pl
  #  - queue each not_started pipeprocess

  # create pipeprocesses for adapter removal
  my @processes = $process_manager->create_new_pipeprocesses();

  my $pipeprocess_rs = $schema->resultset('Pipeprocess')->search();

  while (my $pipeprocess = $pipeprocess_rs->next()) {
    if ($pipeprocess->status()->name() eq 'not_started') {
      $pipeprocess->job_identifier('some_job');
      $pipeprocess->time_queued(DateTime->now());
      $pipeprocess->status($queued_status);
      $pipeprocess->update();
    }
  }

  $pipeprocess_rs = $schema->resultset('Pipeprocess')->search();

  if ($i == 0) {
    is($pipeprocess_rs->count(), 6, 'process count');
  } else {
    is($pipeprocess_rs->count(), 12, 'process count');
  }

  # fake what pipework.pl does to test the runables
  while (my $pipeprocess = $pipeprocess_rs->next()) {
    if ($pipeprocess->status()->name() ne 'queued') {
      next;
    }

    $pipeprocess->time_started(DateTime->now());
    $pipeprocess->status($started_status);
    $pipeprocess->update();

    my $process_type_name = $pipeprocess->process_conf()->type()->name();

    my @pipedatas = $pipeprocess->input_pipedatas();
    ok(@pipedatas == 1, 'one pipedata as input to the pipeprocess');
    my $pipedata = $pipedatas[0];

    SmallRNA::PipeWork::run_process(schema => $schema, config => $config,
                                    pipeprocess => $pipeprocess);

    if ($process_type_name =~ /^remove adapters/) {
      my $remove_adapters_string = 'remove_adapters_rejected_reads';
      my $small_rna_seq_string = 'small_rna_seq';

      if ($pipedata->file_name() =~ /SL236/) {
        # no barcodes:
        my $prefix = "SL236.090227.311F6AAXX.s_1";

        my $out_file_name = $config->data_directory() . "/SL236/$prefix.$small_rna_seq_string.fasta";
        my $rej_file_name = $config->data_directory() . "/$remove_adapters_string/$prefix.$remove_adapters_string.fasta";

        ok(-e $out_file_name, 'looking for output file');
        ok(-e $rej_file_name, 'looking for reject file');
      } else {
        if ($pipedata->file_name() =~ /SL234/) {
          my $common = "090202.30W8NAAXX.s_1";

          my $b_out_file_name = $config->data_directory() . "/SL234_B/SL234_B.$common.$small_rna_seq_string.fasta";
          my $c_out_file_name = $config->data_directory() . "/SL234_C/SL234_C.$common.$small_rna_seq_string.fasta";
          my $rej_file_name = $config->data_directory() . "/$remove_adapters_string/SL234_BCF.$common.$remove_adapters_string.fasta";

          ok(-s $b_out_file_name, "look for $b_out_file_name");
          ok(-s $c_out_file_name, "look for $c_out_file_name");
          ok(-s $rej_file_name, "looking for reject file ($rej_file_name)");
        }
      }
    } else {
      if ($process_type_name =~ /ssaha alignment/) {
        if ($pipedata->file_name() =~ /SL236/) {
          # TODO
        }
      }
    }
  }
}
