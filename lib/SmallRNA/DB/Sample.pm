package SmallRNA::DB::Sample;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("sample");
__PACKAGE__->add_columns(
  "sample_id",
  {
    data_type => "integer",
    default_value => "nextval('sample_sample_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "created_stamp",
  {
    data_type => "timestamp without time zone",
    default_value => "now()",
    is_nullable => 0,
    size => 8,
  },
  "name",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "pipeproject",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "genotype",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "description",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "protocol",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "molecule_type",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "treatment_type",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "fractionation_type",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "processing_requirement",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "tissue",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
);
__PACKAGE__->set_primary_key("sample_id");
__PACKAGE__->add_unique_constraint("sample_name_key", ["name"]);
__PACKAGE__->add_unique_constraint("sample_id_pk", ["sample_id"]);
__PACKAGE__->has_many(
  "coded_samples",
  "SmallRNA::DB::CodedSample",
  { "foreign.sample" => "self.sample_id" },
);
__PACKAGE__->belongs_to("tissue", "SmallRNA::DB::Tissue", { tissue_id => "tissue" });
__PACKAGE__->belongs_to(
  "genotype",
  "SmallRNA::DB::Genotype",
  { genotype_id => "genotype" },
);
__PACKAGE__->belongs_to(
  "processing_requirement",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "processing_requirement" },
);
__PACKAGE__->belongs_to(
  "treatment_type",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "treatment_type" },
);
__PACKAGE__->belongs_to(
  "pipeproject",
  "SmallRNA::DB::Pipeproject",
  { pipeproject_id => "pipeproject" },
);
__PACKAGE__->belongs_to(
  "fractionation_type",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "fractionation_type" },
);
__PACKAGE__->belongs_to(
  "molecule_type",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "molecule_type" },
);
__PACKAGE__->has_many(
  "sample_ecotypes",
  "SmallRNA::DB::SampleEcotype",
  { "foreign.sample" => "self.sample_id" },
);
__PACKAGE__->has_many(
  "sample_pipedatas",
  "SmallRNA::DB::SamplePipedata",
  { "foreign.sample" => "self.sample_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qUUUlp0HVyggzFFs9i/wGQ

__PACKAGE__->many_to_many('pipedatas' => 'sample_pipedatas', 'pipedata');
__PACKAGE__->many_to_many('ecotypes' => 'sample_ecotypes', 'ecotype');

1;
