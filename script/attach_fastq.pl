#!/usr/bin/perl -w

# Script to read the /data/pipeline/process/fastq directory and compare it with
# the pipedata objects in the database.  It will report inconsistencies and
# fix the filename in the pipedata objects.

use strict;

use SmallRNA::Config;
use SmallRNA::DB;
use SmallRNA::DBLayer::Loader;

my $schema = SmallRNA::DB->schema();

sub work
{
  my $data_rs = $schema->resultset('Pipedata')->search();

  my %db_pipedata = ();

  sub name_trim
  {
    my $file_name = shift;
    $file_name =~ s/\.f[aq](?:\.gz)?$//;
    $file_name =~ s/^SL\d+.(.*).reads.*/$1/;
    return $file_name;
  }

  while (my $data = $data_rs->next) {
    my $file_name = $data->file_name();

    $file_name = name_trim($file_name);

    if (exists $db_pipedata{$file_name}) {
      warn "overwriting db name: $file_name\n";
    }
    $db_pipedata{$file_name} = $data;
  }

  my %dir_files = ();

  my $dir_name = SmallRNA::Config->data_directory() . "/fastq";

  opendir my $dir, $dir_name or die "can't open directory $dir_name: $!\n";

  while (my $ent = readdir $dir) {
    next if $ent eq '.' or $ent eq '..';
    my $trimmed_name = name_trim($ent);
    if (exists $dir_files{$trimmed_name}) {
      warn "overwriting dir name: $trimmed_name\n";
    }
    $dir_files{$trimmed_name} = $ent;
  }

  closedir $dir;

  sub hash_file
  {
    my $hash_ref = shift;
    my $file_name = shift;

    return ($hash_ref->{$file_name} ||
            $hash_ref->{"$file_name.gz"} ||
            $hash_ref->{"$file_name.fq"} ||
            $hash_ref->{"$file_name.fq.gz"});
  }

  for my $db_filename (keys %db_pipedata) {
    my $obj = $db_pipedata{$db_filename};
    if (hash_file(\%dir_files, $db_filename)) {
      warn "found $dir_files{$db_filename} matches: ", $obj->file_name(), " setting filename to ", $dir_files{$db_filename}, "\n";
      $obj->file_name($dir_files{$db_filename});
    } else {
      warn "file missing: $db_filename - removing filename from db\n";
      $obj->file_name(undef);
    }
    $obj->update();
  }

  for my $dir_filename (keys %dir_files) {
    if (!hash_file(\%db_pipedata, $dir_filename)) {
      warn "db entry missing: $dir_filename\n";
    }
  }
}

$schema->txn_do(\&work);
