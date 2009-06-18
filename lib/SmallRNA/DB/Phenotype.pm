package SmallRNA::DB::Phenotype;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("phenotype");
__PACKAGE__->add_columns(
  "phenotype_id",
  {
    data_type => "integer",
    default_value => "nextval('phenotype_phenotype_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "uniquename",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "observable_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "attr_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "value",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "cvalue_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "assay_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
);
__PACKAGE__->set_primary_key("phenotype_id");
__PACKAGE__->add_unique_constraint("phenotype_c1", ["uniquename"]);
__PACKAGE__->add_unique_constraint("phenotype_pkey", ["phenotype_id"]);
__PACKAGE__->has_many(
  "feature_phenotypes",
  "SmallRNA::DB::FeaturePhenotype",
  { "foreign.phenotype_id" => "self.phenotype_id" },
);
__PACKAGE__->belongs_to("cvalue", "SmallRNA::DB::Cvterm", { cvterm_id => "cvalue_id" });
__PACKAGE__->belongs_to(
  "observable",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "observable_id" },
);
__PACKAGE__->belongs_to("attr", "SmallRNA::DB::Cvterm", { cvterm_id => "attr_id" });
__PACKAGE__->belongs_to("assay", "SmallRNA::DB::Cvterm", { cvterm_id => "assay_id" });
__PACKAGE__->has_many(
  "phenotype_comparison_phenotype1_ids",
  "SmallRNA::DB::PhenotypeComparison",
  { "foreign.phenotype1_id" => "self.phenotype_id" },
);
__PACKAGE__->has_many(
  "phenotype_comparison_phenotype2_ids",
  "SmallRNA::DB::PhenotypeComparison",
  { "foreign.phenotype2_id" => "self.phenotype_id" },
);
__PACKAGE__->has_many(
  "phenotype_cvterms",
  "SmallRNA::DB::PhenotypeCvterm",
  { "foreign.phenotype_id" => "self.phenotype_id" },
);
__PACKAGE__->has_many(
  "phenstatements",
  "SmallRNA::DB::Phenstatement",
  { "foreign.phenotype_id" => "self.phenotype_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tHztcBQ0Lu4Ln+6a5zrDlw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
