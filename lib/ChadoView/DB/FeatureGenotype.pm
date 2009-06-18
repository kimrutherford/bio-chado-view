package ChadoView::DB::FeatureGenotype;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("feature_genotype");
__PACKAGE__->add_columns(
  "feature_genotype_id",
  {
    data_type => "integer",
    default_value => "nextval('feature_genotype_feature_genotype_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "feature_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "genotype_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "chromosome_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "rank",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "cgroup",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "cvterm_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("feature_genotype_id");
__PACKAGE__->add_unique_constraint("feature_genotype_pkey", ["feature_genotype_id"]);
__PACKAGE__->add_unique_constraint(
  "feature_genotype_feature_id_key",
  [
    "feature_id",
    "genotype_id",
    "cvterm_id",
    "chromosome_id",
    "rank",
    "cgroup",
  ],
);
__PACKAGE__->belongs_to(
  "chromosome",
  "ChadoView::DB::Feature",
  { feature_id => "chromosome_id" },
);
__PACKAGE__->belongs_to(
  "feature",
  "ChadoView::DB::Feature",
  { feature_id => "feature_id" },
);
__PACKAGE__->belongs_to(
  "genotype",
  "ChadoView::DB::Genotype",
  { genotype_id => "genotype_id" },
);
__PACKAGE__->belongs_to(
  "cvterm",
  "ChadoView::DB::Cvterm",
  { cvterm_id => "cvterm_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:HAfT+aEAAbT0BXbWLH7+QA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
