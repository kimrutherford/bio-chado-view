use strict;
use warnings;
use Test::More tests => 3;
use File::Temp qw(tempdir);

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Process::RemoveAdaptersProcess';
}

my $in_fastq_file = 't/data/SL236.090227.311F6AAXX.s_1.fq';

my $tempdir = tempdir("/tmp/remove_adapters_test_$$.XXXXX", CLEANUP => 0);

my ($reject_file_name, $fasta_file_name, $output_file_name) =
  SmallRNA::Process::RemoveAdaptersProcess::run(
                                                output_dir_name => $tempdir,
                                                input_file_name => $in_fastq_file
                                               );

ok(-s "$tempdir/$reject_file_name", 'reject file size');
ok(-s "$tempdir/$output_file_name", 'output file size');
