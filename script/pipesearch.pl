#!/usr/bin/perl -w

use strict;
use warnings;
use Carp;

use SmallRNA::DB;
use SmallRNA::Web;
use SmallRNA::Index::Manager;

use Getopt::Long;

my $c = SmallRNA::Web->commandline();
my $config = $c->config();

# set defaults
my %options = (
               search_gff => undef,
               search_fasta => undef,
               show_file_name => undef,
               count_only => undef,
               verbose => undef,
              );

my $option_parser = new Getopt::Long::Parser;
$option_parser->configure("gnu_getopt");

my %opt_config = (
                  "search-gff|g=s" => \$options{search_gff},
                  "search-fasta|s=s" => \$options{search_fasta},
                  "show-file-name|f" => \$options{show_file_name},
                  "count-only|c" => \$options{count_only},
                  "verbose|v" => \$options{verbose},
                 );

sub usage
{
  die <<"USAGE";
usage: $0 [-v] [-c] <-s|-g> <sequence>

options:
  -s search for a sequence in all non-redundant fasta files
  -g search for occurrence of a sequence in a GFF file
  -f show the matching file name before each match
  -c show the count of matches, rather than the matches
  -v verbose

One of -g or -s must be specified
USAGE
}

if (!$option_parser->getoptions(%opt_config)) {
  usage();
}

if (!($options{search_fasta} || $options{search_gff})) {
  usage();
}

my $search_sequence = $options{search_fasta} || $options{search_gff};

my $schema = SmallRNA::DB->schema($config);

my $file_format;

if ($options{search_fasta}) {
  $file_format = 'seq_offset_index';
} else {
  $file_format = 'seq_offset_index';
}

my $rs = $schema->resultset('Cvterm')->search({
  name => $file_format
})->search_related('pipedata_format_types');

my $manager = SmallRNA::Index::Manager->new();

my $data_dir = $config->data_directory();

while (defined (my $pipedata = $rs->next())) {
  my $pipeprocess = $pipedata->generating_pipeprocess();
  my @input_pipedatas = $pipeprocess->input_pipedatas();

  my $file_name = $input_pipedatas[0]->file_name();
  my $index_file_name = $pipedata->file_name();

  if ($options{verbose}) {
    print "checking $file_name\n";
  }

  my @res = $manager->search(input_file_name => $data_dir . '/' . $file_name,
                             index_file_name => $data_dir . '/' . $index_file_name,
                             search_sequence => $search_sequence);


  my $maybe_file_name = '';

  if ($options{show_file_name}) {
    $maybe_file_name = $data_dir . '/' . $file_name . ': ';
  }

  if ($options{count_only}) {
    print $maybe_file_name, scalar(@res), "\n";
  } else {
    for my $res (@res) {
      print $maybe_file_name, "$res\n";
    }
  }
}
