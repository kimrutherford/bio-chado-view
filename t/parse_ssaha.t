use strict;
use warnings;
use Test::More tests => 36;

BEGIN {
  use_ok 'SmallRNA::Parse::SSAHA';
}

sub test_output
{
  my $parser = shift;
  my $full = shift;

  my $match = $parser->next();

  ok($match->{qid} eq 'HWI-EAS202_30W8NAAXX:1:1:1484:1967');
  ok($match->{qstart} == 1);
  ok($match->{qend} == 23);
  ok($match->{sstart} == 15874591);
  ok($match->{send} == 15874613);
  ok($match->{forward_match} == 1);
  if ($full) {
    ok($match->{matching_base_count} == 23);
  }

  $match = $parser->next();

  ok($match->{qid} eq 'HWI-EAS202_30W8NAAXX:1:1:1712:153');
  ok($match->{qstart} == 7);
  ok($match->{qend} == 24);
  ok($match->{sstart} == 3897151);
  ok($match->{send} == 3897168);
  if ($full) {
    ok($match->{matching_base_count} == 18);
  }

  $match = $parser->next();

  ok($match->{qid} eq 'HWI-EAS202_30W8NAAXX:1:1:1341:1951');
  ok($match->{qstart} == 1);
  ok($match->{qend} == 24);
  ok($match->{sstart} == 12263714);
  ok($match->{send} == 12263737);
  if ($full) {
    ok($match->{matching_base_count} == 24);
  }
}

my $in_file = 't/data/parse_ssaha_data.sssaha';
open my $fh, '<', $in_file or die "can't open $in_file: $!\n";

my $parser = SmallRNA::Parse::SSAHA->new(input_file_handle => $fh, format => 'pf');
test_output($parser);

my $in_file_full = 't/data/parse_ssaha_data_full.sssaha';
open my $fh_full, '<', $in_file_full or die "can't open $in_file_full: $!\n";
$parser = SmallRNA::Parse::SSAHA->new(input_file_handle => $fh_full,
                                      format => 'standard');
test_output($parser, 1);
