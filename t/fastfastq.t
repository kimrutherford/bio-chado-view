use strict;
use Bio::SeqIO;
use Test::More tests => 4;

my $file = 't/data/fastfastq.fq';

my $seqio = Bio::SeqIO->new(-file => $file, -format => 'fastfastq');

my @seqs = ();

while (defined (my $seq = $seqio->next_seq())) {
  push @seqs, $seq;
}

ok(scalar @seqs == 8);

my $lastseq = $seqs[-1];

ok($lastseq->{id} eq 'HWI-EAS350_306BGAAXX:5:1:1186:2009');
ok($lastseq->{quality} eq 'h\dhF]HSU<LhFC^NK@D??MFDF?MAHEP?@OB@ML@BB?AKD');
ok($lastseq->{sequence} eq 'GAGGGCGGGAAGGTGAAGTTAGAGTCGTATGCCGTCTTCTGTTTG');
