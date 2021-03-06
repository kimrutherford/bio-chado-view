package ChadoView::DB::Phenotype;

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
  "ChadoView::DB::FeaturePhenotype",
  { "foreign.phenotype_id" => "self.phenotype_id" },
);
__PACKAGE__->belongs_to(
  "cvalue",
  "ChadoView::DB::Cvterm",
  { cvterm_id => "cvalue_id" },
);
__PACKAGE__->belongs_to(
  "observable",
  "ChadoView::DB::Cvterm",
  { cvterm_id => "observable_id" },
);
__PACKAGE__->belongs_to("attr", "ChadoView::DB::Cvterm", { cvterm_id => "attr_id" });
__PACKAGE__->belongs_to("assay", "ChadoView::DB::Cvterm", { cvterm_id => "assay_id" });
__PACKAGE__->has_many(
  "phenotype_comparison_phenotype1_ids",
  "ChadoView::DB::PhenotypeComparison",
  { "foreign.phenotype1_id" => "self.phenotype_id" },
);
__PACKAGE__->has_many(
  "phenotype_comparison_phenotype2_ids",
  "ChadoView::DB::PhenotypeComparison",
  { "foreign.phenotype2_id" => "self.phenotype_id" },
);
__PACKAGE__->has_many(
  "phenotype_cvterms",
  "ChadoView::DB::PhenotypeCvterm",
  { "foreign.phenotype_id" => "self.phenotype_id" },
);
__PACKAGE__->has_many(
  "phenstatements",
  "ChadoView::DB::Phenstatement",
  { "foreign.phenotype_id" => "self.phenotype_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qyGO3bX87sWpuEyYHd+Lzw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
