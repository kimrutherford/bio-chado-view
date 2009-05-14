use strict;
use warnings;
use Test::More tests => 3;
use File::Temp qw(tempfile);
use File::Compare;

use YAML;

use SmallRNA::Config;

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Process::SSAHASearchProcess';
}

my $input_file_name = 't/data/reads_fasta_summary_test.fasta';
my $db_file_name = 't/data/test_genome.fasta';

my ($gff_fh, $output_gff_file_name) =
  tempfile('/tmp/ssaha_search_test_gff.XXXXXX', UNLINK => 0);

my $config = SmallRNA::Config->new('t/test_config.yaml')->{programs}{ssaha};

my $res = SmallRNA::Process::SSAHASearchProcess::run(
  ssaha_path => $config->{path},
  database_file_name => $db_file_name,
  input_file_name => $input_file_name,
  gff_source_name => 'test_source',
  output_gff_file_name => $output_gff_file_name,
);

ok(-s $output_gff_file_name, 'has gff output');

ok(compare($output_gff_file_name, "t/data/ssaha_search_gff.results") == 0,
  'gff results comparison');
