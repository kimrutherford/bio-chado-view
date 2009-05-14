#!/usr/bin/perl -w

use strict;
use warnings;
use Carp;

use SmallRNA::DB;
use SmallRNA::Web;

my $c = SmallRNA::Web->commandline();
my $config = $c->config();

my $schema = SmallRNA::DB->schema($config);

my $database_config = "";
my $track_config = "";


my $sample_rs = $schema->resultset('Sample');

while (defined (my $sample = $sample_rs->next())) {
  if ($sample->ecotype()->organism()->full_name() eq 'Arabidopsis thaliana') {
    my $sample_name = $sample->name();

    next if $sample_name =~ /_[A-Z]$/;


    my $owner = $sample->pipeproject()->owner();
    my $user_name = $owner->user_name();
    my $first_name = $owner->first_name();
    my $last_name = $owner->last_name();

    my $org_name = $owner->organisation()->name();

    if (0) {
      $database_config .= <<"DATABASE";

[${sample_name}_db:database]
db_adaptor    = Bio::DB::SeqFeature::Store
db_args       = -adaptor        DBI::mysql
                -dsn    dbi:mysql:database=gbrowse_$sample_name:host=silicon
                -user   pipe
                -pass   pipe

DATABASE
    }

    $track_config .= <<"TRACK";
[$sample_name]
feature = ssaha:$sample_name
database = ${sample_name}_db
glyph        = arrow
fgcolor      = \\&fgcolor
linewidth    = \\&abundance
description  = 1
key          = $sample_name
category     = $org_name - $first_name $last_name

TRACK

  }
}

open my $devnull, '>', '/dev/null' or die;

my $init_code = <<'INIT_CODE';
sub fgcolor {
  my $feature=shift;
  my $len = ($feature->stop - $feature->start +1);
  return "pink" if ($len >=15 and $len <20);
  return "red" if ($len >=20 and $len <= 21);
  return "green" if $len >=22 and $len <=23;
  return "blue" if $len >=24 and $len <=25;
  return "gray"
 }
 sub abundance{
   my $feature = shift;
   my $score = log($feature->score);
   return $score
 }
INIT_CODE

print <<"END";
[GENERAL]
description   = Arabidopsis thaliana TAIR8
db_adaptor    = Bio::DB::SeqFeature::Store
db_args       = -adaptor        DBI::mysql
                -dsn    dbi:mysql:database=arabidopsis_tair_8_all:host=localhost
                -user   pipe
                -pass   pipe

gbrowse root = gbrowse-1.69
stylesheet   = gbrowse.css
buttons      = images/buttons
js           = js
tmpimages   = /gbrowse-1.69

initial landmark = Chr1:1504365..1514364

default tracks = transposable_element
    Chromosome:overview

# examples to show in the introduction
examples = Chr1:1504365..1514364
           ChrC:63781..68780

plugins = FastaDumper

# "automatic" classes to try when an unqualified identifier is given
automatic classes = chromosome gene five_prime_UTR mRNA exon three_prime_UTR

init_code = $init_code

max segment = 50000
default segment = 5000

# Default glyph settings
glyph       = generic
height      = 8
bgcolor     = cyan
fgcolor     = cyan
label density = 25
bump density  = 100

# where to link to when user clicks in detaild view
#link          = http://atidb.org/
link = AUTO

# what image widths to offer
image widths  = 450 640 800 1024

# default width of detailed view (pixels)
default width = 1024
default features = ncRNA
                   DNA
                   Col_combined


# max and default segment sizes for detailed view
max segment     = 500000
default segment = 50000

# zoom levels
zoom levels    = 100 200 1000 2000 5000 10000 20000 40000 100000 200000 500000 1000000
low res = 200000


#################################
# database definitions
#################################
[arabidopsis_gff3:database]
db_adaptor    = Bio::DB::SeqFeature::Store
db_args       = -adaptor	DBI::mysql
                -dsn	dbi:mysql:database=arabidopsis_tair_8:host=localhost
                -user	pipe
                -pass   pipe

$database_config

######### end database definitions ############

# Default glyph settings
[TRACK DEFAULTS]
glyph       	= generic
height      	= 8
bgcolor     	= steelblue
fgcolor     	= black
label density	= 25
bump density  	= 100
default varying = 1

### TRACK CONFIGURATION ####
# the remainder of the sections configure individual tracks

#[Chromosome:overview]
#feature		= chromosome
#bgcolor       	= lightslategray
#glyph         	= generic
#fgcolor       	= black
#height        	= 8
#point         	= 1
#citation      	= This track shows the entire chromosome.  A vertical red line shows the position of the detail view below.
#key           	= Chromosome

[BAC]
feature      	= BAC_cloned_genomic_insert
glyph        	= anchored_arrow
bgcolor      	= darkviolet
strand_arrow 	= 1
description  	= 1
category	= Assembly
key          	= Annotation Units
link         	= http://www.arabidopsis.org/servlets/TairObject?name=\$name&type=assembly_unit
citation     	= The positions of the BAC and other genomic clones making up the tiling path are shown.


[Locus]
feature      	= gene pseudogene transposable_element_gene
glyph        	= generic
bgcolor      	= darksalmon
fgcolor      	= black
font2color   	= blue
strand_arrow 	= 1
height       	= 6
ignore_sub_part = pseudogenic_transcript mRNA ncRNA tRNA snoRNA snRNA rRNA
link         	= http://www.arabidopsis.org/servlets/TairObject?name=\$name&type=locus
description  	= 1
key          	= Locus
category     	= Gene
title		= sub {
				my \$feature = shift;
				my \$n = \$feature->name();
				my \$ref = \$feature->seq_id();
				my \$start = \$feature->start();
				my \$end = \$feature->end();
				return "Locus: \$n \$ref:\$start..\$end";
			}

citation     	= Each locus along with its type is shown here.  Loci are essentially equivalent to genes.



[ProteinCoding]
feature         = mRNA
glyph           = processed_transcript
bgcolor         = steelblue
fgcolor         = blue
utr_color       = lightblue
label density   = 50
bump density    = 150
description     = 0
link		= http://www.arabidopsis.org/servlets/TairObject?name=\$name&type=gene
key             = Protein Coding Gene Models
category        = Gene
citation        = Splice variants for loci classed as protein-coding appear in this track.  


$track_config

END


