#!/usr/bin/perl -w

# script to populate the barcode table

use strict;

use warnings;

use SmallRNA::DB;
use SmallRNA::DBLayer::Loader;

use SmallRNA::Web;

my $c = SmallRNA::Web->commandline();
my $config = $c->config();

my $schema = SmallRNA::DB->schema($config);

my %barcodes = (
                TACCT => 'A',
                TACGA => 'B',
                TAGCA => 'C',
                TAGGT => 'D',
                TCAAG => 'E',
                TCATC => 'F',
                TCTAC => 'G',
                TCTTG => 'H',
                TGAAC => 'I',
                TGTTG => 'J',
                TGTTC => 'K',
               );

my $loader = SmallRNA::DBLayer::Loader->new(schema => $schema);

$schema->txn_do(sub {
  for my $barcode (sort keys %barcodes) {
    my $barcode_identifier = $barcodes{$barcode};

    my $rs = $schema->resultset('Barcode');
    $rs->create({
                 identifier => $barcode_identifier,
                 code => $barcode
                });
  }
});

my %terms = (
             'tracking file format types' =>
             {
              'fastq' => 'FastQ format file',
              'fs' => 'FASTA format with an empty description line',
              'fasta' => 'FASTA format',
              'gff3' => 'GFF3 format',
              'seq_offset_index' => 'An index of a GFF3 or FASTA format file',
              'text' => 'A human readable text file with summaries or statistics',
              'tsv' => 'A file containing tab-separated value',
             },
             'tracking file content types' =>
             {
              'raw_small_rna_reads' =>
                'Raw small RNA sequence reads from a non-multiplexed sequencing run, before any processing',
              'multiplexed_small_rna_reads' =>
                'Raw small RNA sequence reads from a multiplexed sequencing run, before any processing',
              'raw_genomic_dna_reads' =>
                'Raw DNA sequence reads with quality scores',
              'small_rna' =>
                'Small RNA sequence reads that have been processed to remove adapters',
              'non_redundant_small_rna' =>
                'Small RNA sequence reads without adapters with redundant sequences removed',
              'genomic_dna_tags' =>
                'DNA reads that have been trimmed to a fixed number of bases',
              'small_rna_reads_nuclear_alignment' =>
                'Small RNA to genome alignments',
              'small_rna_reads_mitochondrial_alignment' =>
                'Small RNA to mitochondrial dna alignments',
              'small_rna_reads_chloroplast_alignment' =>
                'Small RNA to chloroplast dna alignments',
              'remove_adapter_rejects' =>
                'Small RNA sequence reads that were rejected by the remove adapters step',
              'remove_adapter_unknown_barcode' =>
                'Small RNA sequence reads that were rejected by the remove adapters step because they did not match an expected barcode',
              'first_base_summary' =>
                'A summary of the first base composition of sequences from a fasta file',
              'genome_matching_srna' =>
                'Reads that match the genome with a 100% full-length match',
              'genome_aligned_srna_reads' =>
                'Small RNA reads that have been aligned against the genome',
              'gff3_index' =>
                'An index of a gff3 file that has the read sequence as the key',
              'fasta_index' =>
                'An index of a fasta file that has the sequence as the key',
             },
             'tracking sequencing method' =>
             {
              'Illumina' => 'Illumina sequencing method',
             },
             'tracking multiplexing types' =>
             {
              'non-multiplexed' => 'One sample per sequencing run',
              'DCB multiplexed' => 'multiplexed sequencing run using DCB group barcodes',
             },
             'tracking project types' =>
             {
              'small RNA sequencing' => 'Small RNA sequencing',
              'DNA tag sequencing' => 'Sequencing of fragments of genomic DNA',
             },
             'tracking molecule types' =>
             {
              'DNA' => 'Deoxyribonucleic acid',
              'RNA' => 'Ribonucleic acid',
             },
             'tracking quality values' =>
             {
              'high' => 'high quality',
              'medium' => 'medium quality',
              'low' => 'low quality',
              'unknown' => 'unknown quality',
             },
             'tracking pipeprocess status' =>
             {
              'not_started' => 'Process has not been queued yet',
              'queued' => 'A job is queued to run this process',
              'started' => 'Processing has started',
              'finished' => 'Processing is done',
             },
             'tracking sample processing requirements' =>
             {
              'no processing' => 'Processing should not be performed for this sample',
              'needs processing' =>' Processing should be performed for this sample',
             },
             'tracking analysis types' =>
             {
              'non-multiplexed sequencing run' =>
                'This pseudo-analysis generates raw sequence files, ' .
                'with quality scores, with no multiplexing',
              'multiplexed sequencing run' =>
                'This pseudo-analysis generates raw sequence files, ' .
                'with quality scores, and uses multiplexing/barcodes',
              'remove adapters' => 'Read FastQ files, process each read to remove the adapter',
              'remove adapters and de-multiplex' =>
                'Read FastQ files, process each read to remove the adapter and split the result based on the barcode',
              'trim reads' =>
                'Read FastQ files, trim each read to a fixed length and then create a fasta file',
              'summarise fasta first base' =>
                'Read a fasta file of short sequences and summarise the first base composition',
              'remove redundant reads' =>
                'Read a fasta file of short sequences, remove redundant reads '
                  . 'and add a count to the header',
              'ssaha alignment' =>
                'Align reads against a sequence database with SSAHA',
              'genome aligned reads filter' =>
                'Filter a fasta file, creating a file containing only genome aligned reads',
              'gff3 index' =>
                'Create an index of GFF3 file',
              'fasta index' =>
                'Create an index of FASTA file',
             },
             'tracking coded sample types' =>
             {
              'initial run' => 'intial sequencing run',
              'technical replicate' => 'technical replicate/re-run',
              'biological replicate' => 'biological replicate/re-run',
              'failure re-run' => 're-run because of failure'
             },
             'tracking treatment types' => { 'no treatment' => 'no treatment' },
             'tracking fractionation types' => { 'no fractionation' => 'no fractionation' },
            );

my %cvterm_objs = ();

$schema->txn_do(sub {
  for my $term_cv_name (sort keys %terms) {
    my $cv_rs = $schema->resultset('Cv');
    my $cv = $cv_rs->create({ name => $term_cv_name});

    my %cvterms = %{$terms{$term_cv_name}};

    for my $cvterm_name (sort keys %cvterms) {
      my $definition = $cvterms{$cvterm_name};

      my $rs = $schema->resultset('Cvterm');

      my $obj = $rs->create({name => $cvterm_name,
                             definition => $definition,
                             cv_id => $cv});

      $cvterm_objs{$cvterm_name} = $obj;
    }
  }
});

$schema->txn_commit();

my @orgs = ({ name => "DCB",
              description => "David Baulcombe Lab, University of Cambridge, Dept. of Plant Sciences" },
            { name => 'CRUK CRI',
              description => 'Cancer Research UK, Cambridge Research Institute' },
            { name => 'Sainsbury',
              description => 'The Sainsbury Laboratory' },
            { name => 'JIC',
              description => 'The John Innes Centre' },
           );

$schema->txn_do(sub {
                  for my $org (@orgs) {
                    $schema->create_with_type('Organisation', $org);
                  }
                });
my @organisms = ({ genus => "Arabidopsis", species => "thaliana" },
                 { genus => "Chlamydomonas", species => "reinhardtii" },
                 { genus => "Cardamine", species => "hirsuta" },
                 { genus => "Caenorhabditis", species => "elegans" },
                 { genus => "Dictyostelium", species => "discoideum" },
                 { genus => "Homo", species => "sapiens" },
                 { genus => "Lycopersicon", species => "esculentum" },
                 { genus => "Zea", species => "mays" },
                 { genus => "Nicotiana", species => "benthamiana" },
                 { genus => "Schizosaccharomyces", species => "pombe" },
                 { genus => "Carmovirus", species => "turnip crinkle virus" },
                 { genus => "Unknown", species => "unknown" },
                );

my %organism_objects = ();

$schema->txn_do(sub {
                  for my $organism_desc (@organisms) {
                    my $organism_obj = $loader->add_organism($organism_desc);
                    my $key = $organism_obj->genus() . ' ' . $organism_obj->species();
                    $organism_objects{$key} = $organism_obj;
                  }
                });

my @ecotypes = ({ description => "unspecified", org => "Arabidopsis thaliana" },
                { description => "unspecified", org => "Chlamydomonas reinhardtii" },
                { description => "unspecified", org => "Cardamine hirsuta" },
                { description => "unspecified", org => "Caenorhabditis elegans" },
                { description => "unspecified", org => "Dictyostelium discoideum" },
                { description => "unspecified", org => "Homo sapiens" },
                { description => "unspecified", org => "Lycopersicon esculentum" },
                { description => "unspecified", org => "Zea mays" },
                { description => "unspecified", org => "Nicotiana benthamiana" },
                { description => "unspecified", org => "Schizosaccharomyces pombe" },
                { description => "unspecified", org => "Unknown unknown" },
               );

$schema->txn_do(sub {
                  for my $ecotype (@ecotypes) {
                    my $org_obj = $organism_objects{$ecotype->{org}};
                    $schema->create_with_type('Ecotype',
                                                {
                                                  description => $ecotype->{description},
                                                  organism => $org_obj,
                                                });
                  }
                });

my @people = (
              ['Andy Bassett', 'andy_bassett', 'DCB'],
              ['David Baulcombe', 'david_baulcombe', 'DCB'],
              ['Amy Beeken', 'amy_beeken', 'DCB'],
              ['Paola Fedita', 'paola_fedita', 'DCB'],
              ['Susi Heimstaedt', 'susi_heimstaedt', 'DCB'],
              ['Jagger Harvey', 'jagger_harvey', 'DCB'],
              ['Ericka Havecker', 'ericka_havecker', 'DCB'],
              ['Ian Henderson', 'ian_henderson', 'DCB'],
              ['Charles Melnyk', 'charles_melnyk', 'DCB'],
              ['Attila Molnar', 'attila_molnar', 'DCB'],
              ['Becky Mosher', 'becky_mosher', 'DCB'],
              ['Kanu Patel', 'kanu_patel', 'DCB'],
              ['Anna Peters', 'anna_peters', 'DCB'],
              ['Kim Rutherford', 'kim_rutherford', 'DCB'],
              ['Iain Searle', 'iain_searle', 'DCB'],
              ['Padubidri Shivaprasad', 'padubidri_shivaprasad', 'DCB'],
              ['Shuoya Tang', 'shuoya_tang', 'DCB'],
              ['Laura Taylor', 'laura_taylor', 'DCB'],
              ['Craig Thompson', 'craig_thompson', 'DCB'],
              ['Natasha Elina', 'natasha_elina', 'DCB'],
              ['Hannes V', 'hannes_v', 'DCB'],
             );

$schema->txn_do(sub {
  for my $person (@people) {
    my ($person_name, $username, $organisation_name) = @$person;

    my $rs = $schema->resultset('Organisation');
    my $organisation = $rs->find({
                                  name => $organisation_name
                                 });

    if ($person_name =~ /(.*) (.*)/) {
      $loader->add_person(first_name => $1, last_name => $2,
                          user_name => $username,
                          password => $username,
                          organisation => $organisation);
    } else {
      die "no space in name: $person_name\n";
    }
  }
});

my @analyses = (
                {
                 type_term_name => 'non-multiplexed sequencing run',
                 detail => 'Sainsbury',
                 inputs => []
                },
                {
                 type_term_name => 'non-multiplexed sequencing run',
                 detail => 'CRI',
                 inputs => []
                },
                {
                 type_term_name => 'multiplexed sequencing run',
                 detail => 'CRI',
                 inputs => []
                },
                {
                 type_term_name => 'remove adapters',
                 runable_name => 'SmallRNA::Runable::RemoveAdaptersRunable',
                 inputs => [
                     {
                       format_type => 'fastq',
                       content_type => 'raw_small_rna_reads',
                     }
                    ]
                },
                {
                  type_term_name => 'remove adapters and de-multiplex',
                  runable_name => 'SmallRNA::Runable::RemoveAdaptersRunable',
                  inputs => [
                      {
                        format_type => 'fastq',
                        content_type => 'multiplexed_small_rna_reads',
                      }
                     ]
                },
                {
                 type_term_name => 'summarise fasta first base',
                 runable_name => 'SmallRNA::Runable::FirstBaseCompSummaryRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'small_rna',
                     }
                    ]
                },
                {
                 type_term_name => 'summarise fasta first base',
                 runable_name => 'SmallRNA::Runable::FirstBaseCompSummaryRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'non_redundant_small_rna',
                     }
                    ]
                },
                {
                 type_term_name => 'summarise fasta first base',
                 runable_name => 'SmallRNA::Runable::FirstBaseCompSummaryRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'raw_small_rna_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'summarise fasta first base',
                 runable_name => 'SmallRNA::Runable::FirstBaseCompSummaryRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'multiplexed_small_rna_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'remove redundant reads',
                 runable_name => 'SmallRNA::Runable::NonRedundantFastaRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'small_rna',
                     }
                    ]
                },
                {
                 type_term_name => 'gff3 index',
                 runable_name => 'SmallRNA::Runable::CreateIndexRunable',
                 inputs => [
                     {
                       format_type => 'gff3',
                       content_type => 'genome_aligned_srna_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'fasta index',
                 runable_name => 'SmallRNA::Runable::CreateIndexRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'non_redundant_small_rna',
                     }
                    ]
                },
                {
                 type_term_name => 'ssaha alignment',
                 detail => 'versus: nuclear_genome',
                 runable_name => 'SmallRNA::Runable::SSAHASearchRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'non_redundant_small_rna',
                     }
                    ]
                },
                {
                 type_term_name => 'genome aligned reads filter',
                 runable_name => 'SmallRNA::Runable::GenomeMatchingReadsRunable',
                 inputs => [
                     {
                       format_type => 'gff3',
                       content_type => 'genome_aligned_srna_reads'
                     }
                   ]
                },
                # {
                #  type_term_name => 'ssaha alignment',
                #  detail => 'versus: Arabidopsis tRNA+rRNA',
                #  runable_name => 'SmallRNA::Runable::SSAHASearchRunable',
                #  inputs => [
                #      {
                #        format_type => 'fasta',
                #        content_type => 'small_rna',
                #      }
                #     ]
                # }
               );

$schema->txn_do(sub {
  for my $analysis (@analyses) {
    my %conf = %$analysis;

    my $type_cvterm_rs = $schema->resultset('Cvterm');
    my $type_cvterm = $type_cvterm_rs->find({ name => $conf{type_term_name} });

    if (!defined $type_cvterm) {
      die "can't find cvterm for $conf{type_term_name}\n";
    }

    my $process_conf = $schema->create_with_type('ProcessConf', {
      type => $type_cvterm,
      detail => $conf{detail},
      runable_name => $conf{runable_name},
    });

    for my $input (@{$conf{inputs}}) {
      $schema->create_with_type('ProcessConfInput', {
        process_conf => $process_conf,
        content_type => $cvterm_objs{$input->{content_type}},
        format_type => $cvterm_objs{$input->{format_type}}
      });
    }
  }
});
