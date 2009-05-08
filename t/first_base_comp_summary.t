use strict;
use warnings;
use Test::More tests => 5;
use File::Temp qw(tempfile);

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Process::FirstBaseCompSummary';
}

my $input_file_name = 't/data/reads_fasta_summary_test.fasta';

my ($fh, $output_file_name) =
  tempfile('/tmp/reads_fasta_summary_test.XXXXXX', UNLINK => 1);

my $res = SmallRNA::Process::FirstBaseCompSummary::run(
                                                       output_file_name => $output_file_name,
                                                       input_file_name => $input_file_name
                                                      );

ok($res->{count}[24] == 7);
ok($res->{first_base_counts}[24]{a} == 5);
ok(-s $output_file_name, 'output file size');

open my $out, '<', $output_file_name;

while (my $line = <$out>) {
  if ($line =~ /^24/) {
    ok($line =~ /71\.4/);
  }
}

close $out;
