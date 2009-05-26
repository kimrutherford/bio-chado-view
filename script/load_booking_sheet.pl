#!/usr/bin/perl -w

# script to load the Solexa booking sheet into the tracking database

use strict;

use warnings;
use Text::CSV;
use IO::All;
use Carp;
use DateTime;

use SmallRNA::DB;
use SmallRNA::DBLayer::Loader;

use SmallRNA::Web;

my $c = SmallRNA::Web->commandline();
my $config = $c->config();

my $test_mode = 0;

if (@ARGV == 2) {
  if ($ARGV[0] eq '-test') {
    $test_mode = 1;
    shift;
  }
}

my $file = shift;

my $csv = Text::CSV->new({binary => 1});

open my $io, '<', $file;

my $schema = SmallRNA::DB->schema($config);

$csv->column_names ($csv->getline($io));

my $loader = SmallRNA::DBLayer::Loader->new(schema => $schema);

my %org_objs = ();

sub add_organism
{
  my $genus = shift;
  my $species = shift;
  my $org = shift;

  my $genus_initial = substr $genus, 0, 1;
  my $fullname = "$genus $species";

  $org_objs{"${genus}_$species}"} = $org;
  $org_objs{$fullname} = $org;
  $org_objs{"${genus_initial}_$species}"} = $org;
  $org_objs{"$genus_initial. $species"} = $org;
  $org_objs{"$genus_initial.$species"} = $org;

  if ($fullname eq 'Schizosaccharomyces pombe') {
    $org_objs{"Pombe"} = $org;
  }
  if ($fullname eq 'Zea mays') {
    $org_objs{"Zea maize"} = $org;
  }
  if ($fullname eq 'Homo sapiens') {
    $org_objs{"H. Sapiens"} = $org;
    $org_objs{"Homo Sapiens"} = $org;
  }
  if ($fullname eq 'Unknown unknown') {
    $org_objs{''} = $org;
  }
}

my $org_rs = $schema->resultset('Organism')->search();

while (my $org = $org_rs->next) {
  my $genus = $org->genus();
  my $species = $org->species();

  add_organism($genus, $species, $org);

  if ($genus eq 'Arabidopsis') {
    add_organism('Arabidosis', $species, $org);
  }
}

my %person_objs = ();

my $person_rs = $schema->resultset('Person')->search();

sub add_person_to_hash
{
  my $first_name = shift;
  my $last_name = shift;
  my $person_obj = shift;

  my $last_name_initial = substr $last_name, 0, 1;

  $person_objs{"$first_name $last_name"} = $person_obj;
  $person_objs{"$first_name $last_name_initial"} = $person_obj;
}


while (my $person = $person_rs->next) {
  my $first_name = $person->first_name();
  my $last_name = $person->last_name();

  add_person_to_hash($first_name, $last_name, $person);

  if ($first_name eq 'Padubidri') {
    add_person_to_hash('Shiva', 'P', $person);
  }
  if ($first_name eq 'Andy') {
    add_person_to_hash('Andrew', $last_name, $person);
  }
  if ($first_name eq 'Natasha') {
    $person_objs{Natasha} = $person;
  }
}

my %projects = ();

sub create
{
  my $type = shift;
  my $args = shift;

  return $schema->create_with_type($type, $args);
}

sub find
{
  my $obj = $schema->find_with_type(@_);
  if (defined $obj) {
    return $obj;
  } else {
    warn "couldn't find $_[0]\n";
  }
}

sub get_project
{
  my $project_name = shift;
  my $owner = shift;
  my $molecule_type = shift;

  $project_name = 'P_' . $project_name;

  my $project_type;

  if ($molecule_type eq 'RNA') {
    $project_type = find('Cvterm', name => 'small RNA sequencing');
  } else {
    $project_type = find('Cvterm', name => 'DNA tag sequencing');
  }

  if (!defined $owner) {
    croak "no owner passed to get_project()\n";
  }

  if (!defined $project_type) {
    croak "no project_type passed to get_project()\n";
  }

  if (!exists $projects{$project_name}) {
    $projects{$project_name} =
      create('Pipeproject', {
                             name => $project_name,
                             description => $project_name,
                             type => $project_type,
                             owner => $owner
                           });
  }
  return $projects{$project_name};
}

sub create_sample
{
  my $project = shift;
  my $sample_name = shift;
  my $description = shift;
  my $sequencing_run = shift;
  my $molecule_type = shift;
  my $ecotype = shift;

  if (!defined $sequencing_run) {
    croak "no sequencing_run passed to create_sample()\n";
  }

  my $molecule_type_term = find('Cvterm', name => $molecule_type);

  die "can't find term for $molecule_type" unless defined $molecule_type_term;

  my $sample_args = {
                     name => $sample_name,
                     description => $description,
                     pipeproject => $project,
                     molecule_type => $molecule_type_term,
                     ecotype => $ecotype,
                    };

  return create('Sample', $sample_args);
}

sub create_samplerun
{
  my $sample = shift;
  my $sequencingrun = shift;
  my $is_replicate = shift;
  my $barcode = shift;

  my %samplerun_args = (
                        sample => $sample,
                        sequencingrun => $sequencingrun,
                        description =>
                          'sample run for: ' . $sample->name()
                       );

  if (defined $barcode) {
    $samplerun_args{barcode} = $barcode;
  }


  if ($is_replicate) {
    $samplerun_args{samplerun_type} = find('Cvterm', name => 'technical replicate');
  } else {
    $samplerun_args{samplerun_type} = find('Cvterm', name => 'initial run');
  }

  return create('Samplerun', {%samplerun_args});
}

my %file_name_to_sequencingrun = ();

# process a file and make a sequencingrun object for it
sub create_sequencing_run
{
  my $run_identifier = shift;
  my $seq_centre_name = shift;
  my $multiplexed = shift;
  my $date_submitted = shift;
  my $date_received = shift;

  $run_identifier = 'R_' . $run_identifier;

  my $multiplexing_type_name;

  if ($multiplexed) {
    $multiplexing_type_name = 'DCB multiplexed';
  } else {
    $multiplexing_type_name = 'non-multiplexed';
  }

  my $sequencing_run = $loader->add_sequencingrun(run_identifier => $run_identifier,
                                                  sequencing_centre_name => $seq_centre_name,
                                                  multiplexing_type_name => $multiplexing_type_name,
                                                  sequencing_type_name => 'Illumina');

  if (defined $date_submitted && length $date_submitted > 0) {
    $sequencing_run->submission_date($date_submitted);
  }
  if (defined $date_received && length $date_received > 0) {
    $sequencing_run->run_date($date_received);
    $sequencing_run->data_received_date($date_received);
  }
  $sequencing_run->update();
}

sub create_pipedata
{
  my $sequencing_run = shift;
  my $file_name = shift;
  my $molecule_type = shift;

  my ($pipedata, $pipeprocess) =
    $loader->add_sequencingrun_pipedata($config, $sequencing_run,
                                        $file_name, $molecule_type);

  $sequencing_run->initial_pipedata($pipedata);
  $sequencing_run->initial_pipeprocess($pipeprocess);

  $sequencing_run->update();

  return $pipedata;
}

sub fix_date
{
  my $date = shift;
  $date =~ s|(\d+)/(\d+)/(0\d)|20$3-$2-${1}T00:00:00|;
  return $date;
}

sub fix_name
{
  my $file_name = shift;
  $file_name =~ s/(?:\.gz)?$//;
  return $file_name;
}

my %dir_files = ();

for my $sub_dir (qw(fastq SL4 SL9 SL11 SL12 SL18 SL19 SL21 SL22)) {
  my $dir_name = $config->{data_directory} . "/$sub_dir";
  opendir my $dir, $dir_name or die "can't open directory $dir_name: $!\n";
  while (my $ent = readdir $dir) {
    next if $ent eq '.' or $ent eq '..' or $ent !~ /\.f[qa]$/;
    $dir_files{$ent} = "$sub_dir/$ent";
  }
  closedir $dir;
}

sub find_real_file_name
{
  my $config = shift;
  my $booking_sheet_file_name = shift;

  if (exists $dir_files{$booking_sheet_file_name}) {
#    warn "found file: $booking_sheet_file_name\n";
    return $dir_files{$booking_sheet_file_name};
  } else {
    my $test_file_name = fix_name($booking_sheet_file_name);

    $test_file_name =~ s/\.reads\.\d+_\d+_\d+//;
    $test_file_name =~ s/\.fa$/.fq/;

    if (exists $dir_files{$test_file_name}) {
#      warn "found file: ", $dir_files{$test_file_name}, " - $test_file_name\n";
      return $dir_files{$test_file_name};
    } else {
      warn "can't find file for $booking_sheet_file_name ($test_file_name)\n";
      return undef;
    }
  }
}

sub get_ecotype_by_org
{
  my $org_obj = shift;

  my $rs = $schema->resultset('Ecotype')->search(
      {
        organism => $org_obj->organism_id()
      }
    );

  if ($rs->count() != 1) {
    croak("failed to find ecotype for organism: ", $org_obj->genus(), ' ',
          $org_obj->species());
  }

  return $rs->next();
}

sub process
{
  while (my $columns_ref = $csv->getline($io)) {
    my @columns = @$columns_ref;
    my ($file_names_column, $solexa_library, $do_processing,
        $dcb_validated, $funding,
        $sheet_seq_centre_name,
        $description, $organism_name, $genotype, $submitter, $institution,
        $date_submitted,
        $date_received, $quality, $quality_note, $sample_type, $run_type,
        $require_number_of_reads, $sample_concentration) = @columns;

    $date_submitted = fix_date($date_submitted);
    $date_received = fix_date($date_received);

    $do_processing = 0;

    my $has_tcv = 0;

    if ($organism_name =~ s|/TCV$||) {
      $has_tcv = 1;
    }

    # XXX TEMP
    if ($solexa_library !~ /SL11$|SL234_BCF|SL236|SL5[45]/ && $test_mode) {
      next;
    }

    if ($file_names_column =~ /ID20_250907_FC5363/) {
      # duplicated lane - Attila - needs fixing
      warn "ignoring $file_names_column\n";
      next;
    }
    # XXX TEMP

    my @file_names = split m|/|, $file_names_column;

    @file_names = grep { ! /^failed/i } @file_names;
    map {
      s/\((.*)\)//; s/^\s+//; s/[\xff\s]+$//;;
    } @file_names;

    my $org_obj = $org_objs{$organism_name};

    if (!defined $org_obj) {
      warn "unknown organism: '$organism_name' from line: @columns\n";
      next;
    }

    my $ecotype = get_ecotype_by_org($org_obj);

    my $person_obj = $person_objs{$submitter};

    if (!defined $person_obj) {
#      warn qq{ignoring row - unknown submitter "$submitter" for '@file_names'\n};
      next;
    }

    # match SL + (_num)? + (_letters)?
    if ($solexa_library =~ /(SL\d+)(?:_([A-Z]+))?(?:_(\d+))?/) {
      my $sample_prefix = $1;
      my $barcodes = $2;
      my $replicate_identifier = $3;

      my $is_replicate = 0;

      my $molecule_type;

      if ($solexa_library eq 'SL54' or $solexa_library eq 'SL55') {
        $molecule_type = 'DNA';
      } else {
        $molecule_type = 'RNA';
      }

      if (defined $replicate_identifier && $replicate_identifier > 1) {
        $is_replicate = 1;
      }

      my $proj = get_project($solexa_library, $person_obj, $molecule_type);

      my $multiplexed;

      if (defined $barcodes) {
        $multiplexed = 1;
      } else {
        $multiplexed = 0;
      }

      for my $file_name (@file_names) {
        if ($file_name =~ /unusable/) {
          warn "skipping: $file_name\n";
          next;
        }

        $file_name =~ s/\s+$//;
        $file_name =~ s/^\s+//;

        if (length $file_name == 0) {
          next;
        }

        $file_name = find_real_file_name($config, $file_name);

        if (!defined $file_name) {
          next;
        }

        die "$file_name\n" unless -e $config->{data_directory} . '/' . $file_name;

        my $seq_centre_name;

        if ($sheet_seq_centre_name eq 'CRI') {
          $seq_centre_name = 'CRUK CRI';
        } else {
          if ($sheet_seq_centre_name eq 'Norwich') {
            $seq_centre_name = 'Sainsbury';
          } else {
            croak "unknown sequencing centre name: $sheet_seq_centre_name\n";
          }
        }

        my $sequencing_run =
          create_sequencing_run($solexa_library, $seq_centre_name,
                                $multiplexed,
                                $date_submitted, $date_received);

        my $pipedata = create_pipedata($sequencing_run, $file_name, $molecule_type);

        my @all_samples = ();

        if ($multiplexed) {
          my @barcode_identifiers = ($barcodes =~ /(\w)/g);
          for my $barcode_identifier (@barcode_identifiers) {
            my $barcode = find('Barcode', identifier => $barcode_identifier);

            my $new_sample_name = $sample_prefix . '_' . $barcode_identifier;

            if (defined $replicate_identifier) {
              $new_sample_name .=  '_' . $replicate_identifier;
            }
            my $sample = create_sample($proj, $new_sample_name, $description,
                                       $sequencing_run, $molecule_type,
                                       $ecotype);
            push @all_samples, $sample;
            create_samplerun($sample, $sequencing_run, $is_replicate, $barcode);
            $pipedata->add_to_samples($sample);
          }
        } else {
          my $sample_name = $sample_prefix;

          if (defined $replicate_identifier) {
            $sample_name .= '_' . $replicate_identifier;
          }

          my $sample = create_sample($proj, $sample_name, $description,
                                     $sequencing_run, $molecule_type,
                                     $ecotype);
          push @all_samples, $sample;
          create_samplerun($sample, $sequencing_run, $is_replicate, undef);
          $pipedata->add_to_samples($sample);
        }

        $pipedata->update();

        my $pipeprocess = $pipedata->generating_pipeprocess();

        my $samples_str = join ', ', map { $_->name() } @all_samples;

        my $new_description =
          $pipeprocess->description() . ' for: ' . $samples_str;
        $pipeprocess->description($new_description);
        $pipeprocess->update();
      }
    } else {
      die "unknown pattern library identifier: $solexa_library\n";
    }
  }
}

eval {
  $schema->txn_do(\&process);
};
if ($@) {
  die "ROLLBACK called: $@\n";

}
