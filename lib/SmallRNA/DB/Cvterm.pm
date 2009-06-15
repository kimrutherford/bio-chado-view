package SmallRNA::DB::Cvterm;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("cvterm");
__PACKAGE__->add_columns(
  "cvterm_id",
  {
    data_type => "integer",
    default_value => "nextval('cvterm_cvterm_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "cv_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "name",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 1024,
  },
  "definition",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "dbxref_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "is_obsolete",
  { data_type => "integer", default_value => 0, is_nullable => 0, size => 4 },
  "is_relationshiptype",
  { data_type => "integer", default_value => 0, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("cvterm_id");
__PACKAGE__->add_unique_constraint("cvterm_pkey", ["cvterm_id"]);
__PACKAGE__->has_many(
  "coded_samples",
  "SmallRNA::DB::CodedSample",
  { "foreign.coded_sample_type" => "self.cvterm_id" },
);
__PACKAGE__->belongs_to("cv_id", "SmallRNA::DB::Cv", { cv_id => "cv_id" });
__PACKAGE__->has_many(
  "genotypes",
  "SmallRNA::DB::Genotype",
  { "foreign.type" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "pipedata_format_types",
  "SmallRNA::DB::Pipedata",
  { "foreign.format_type" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "pipedata_content_types",
  "SmallRNA::DB::Pipedata",
  { "foreign.content_type" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "pipeprocesses",
  "SmallRNA::DB::Pipeprocess",
  { "foreign.status" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "pipeprojects",
  "SmallRNA::DB::Pipeproject",
  { "foreign.type" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "process_confs",
  "SmallRNA::DB::ProcessConf",
  { "foreign.type" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "process_conf_input_format_types",
  "SmallRNA::DB::ProcessConfInput",
  { "foreign.format_type" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "process_conf_input_content_types",
  "SmallRNA::DB::ProcessConfInput",
  { "foreign.content_type" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "sample_processing_requirements",
  "SmallRNA::DB::Sample",
  { "foreign.processing_requirement" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "sample_treatment_types",
  "SmallRNA::DB::Sample",
  { "foreign.treatment_type" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "sample_fractionation_types",
  "SmallRNA::DB::Sample",
  { "foreign.fractionation_type" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "sample_molecule_types",
  "SmallRNA::DB::Sample",
  { "foreign.molecule_type" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "sequencingrun_qualities",
  "SmallRNA::DB::Sequencingrun",
  { "foreign.quality" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "sequencingrun_multiplexing_types",
  "SmallRNA::DB::Sequencingrun",
  { "foreign.multiplexing_type" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "sequencingrun_sequencing_types",
  "SmallRNA::DB::Sequencingrun",
  { "foreign.sequencing_type" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "tissues",
  "SmallRNA::DB::Tissue",
  { "foreign.type" => "self.cvterm_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cZEMh+0WyKv2H7lfWbGjPg

# You can replace this text with custom content, and it will be preserved on regeneration
1;
