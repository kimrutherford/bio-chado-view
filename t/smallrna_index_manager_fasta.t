use strict;
use warnings;

use Test::More tests => 7;

use File::Temp qw(tempfile);
use Test::Files;

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Index::Manager';
}

my $manager = SmallRNA::Index::Manager->new();

my $input_file_name = 't/data/non_redundant_srna_SL234_B.fasta';;
my $test_seq = 'GAGTATCTGAGCCATCTGAAGAAA';

# test index creation
my ($index_fh, $output_index_file_name) =
  tempfile('/tmp/ssaha_index_manager_test_index.XXXXXX', UNLINK => 0);

$manager->create_index(input_file_name => $input_file_name,
                       index_file_name => $output_index_file_name,
                       input_file_type => 'fasta');

ok(-s $output_index_file_name, 'has index output');

compare_ok($output_index_file_name, "t/data/smallrna_fasta_index.results",
           'result comparison');


# test searching the index
my @results = $manager->search(input_file_name => $input_file_name,
                               index_file_name => "t/data/smallrna_fasta_index.results",
                               search_sequence => $test_seq);

is(@results, 1);

@results = $manager->search(input_file_name => $input_file_name,
                            index_file_name => "t/data/smallrna_fasta_index.results",
                            search_sequence => $test_seq);

is(@results, 1);

is($results[0], '>GAGTATCTGAGCCATCTGAAGAAA count:2');


# test searching for something that's not in the index
@results = $manager->search(input_file_name => $input_file_name,
                            index_file_name => "t/data/smallrna_fasta_index.results",
                            search_sequence => 'atatatatatatat');

is(@results, 0);
