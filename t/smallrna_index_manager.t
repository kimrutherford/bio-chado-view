use strict;
use warnings;

use Test::More tests => 5;

use File::Temp qw(tempfile);
use File::Compare;

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Index::Manager';
}

my ($index_fh, $output_index_file_name) =
  tempfile('/tmp/ssaha_index_manager_test_index.XXXXXX', UNLINK => 0);

my $manager = SmallRNA::Index::Manager->new();

$manager->create_index(input_file_name => 't/data/ssaha_search_results.gff',
                       index_file_name => $output_index_file_name);

ok(-s $output_index_file_name, 'has index output');

ok(compare($output_index_file_name, "t/data/smallrna_gff_index.results") == 0,
  'result comparison');

my @gff_results = $manager->search(gff_file_name => 't/data/ssaha_search_results.gff',
                                   index_file_name => 't/data/smallrna_gff_index.results',
                                   search_sequence => 'ACAAAGAGCTCGCCGCAGATAGGA');

is(@gff_results, 3);

my @gff_results = $manager->search(gff_file_name => 't/data/ssaha_search_results.gff',
                                   index_file_name => 't/data/smallrna_gff_index.results',
                                   search_sequence => 'acaaagagctcgccgcagatagga');

is(@gff_results, 3);
