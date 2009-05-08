use strict;
use warnings;
use Test::More tests => 7;
use File::Temp qw(tempdir);

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Process::RemoveAdaptersProcess';
  use_ok 'SmallRNA::Runable::RemoveAdaptersRunable';
}

use SmallRNA::Config;
use SmallRNA::DB;
# use SmallRNA::ProcessManager;
# use SmallRNATest;

my $in_fastq_file = 't/data/SL234_BCF.090202.30W8NAAXX.s_1.fq';

my $tempdir = tempdir("/tmp/remove_adapters_test_$$.XXXXX", CLEANUP => 0);

my $config = SmallRNA::Config->new('t/test_config.yaml');

my $schema = SmallRNA::DB->schema($config);

my %barcodes_map = SmallRNA::Runable::RemoveAdaptersRunable::_get_barcodes($schema);

my ($reject_file_name, $output) =
  SmallRNA::Process::RemoveAdaptersProcess::run(
                                                output_dir_name => $tempdir,
                                                input_file_name => $in_fastq_file,
                                                barcodes => \%barcodes_map
                                               );

ok(-s "$tempdir/$reject_file_name");

ok(scalar(keys %$output) == 3, 'two output files');

ok($output->{TACGA} eq 'SL234_BCF.090202.30W8NAAXX.s_1.B.fasta');
ok($output->{TAGCA} eq 'SL234_BCF.090202.30W8NAAXX.s_1.C.fasta');
ok($output->{TACCT} eq 'SL234_BCF.090202.30W8NAAXX.s_1.A.fasta');
