package SmallRNA::DB::FeaturePhenotype;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("feature_phenotype");
__PACKAGE__->add_columns(
  "feature_phenotype_id",
  {
    data_type => "integer",
    default_value => "nextval('feature_phenotype_feature_phenotype_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "feature_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "phenotype_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("feature_phenotype_id");
__PACKAGE__->add_unique_constraint("feature_phenotype_pkey", ["feature_phenotype_id"]);
__PACKAGE__->add_unique_constraint("feature_phenotype_c1", ["feature_id", "phenotype_id"]);
__PACKAGE__->belongs_to(
  "feature",
  "SmallRNA::DB::Feature",
  { feature_id => "feature_id" },
);
__PACKAGE__->belongs_to(
  "phenotype",
  "SmallRNA::DB::Phenotype",
  { phenotype_id => "phenotype_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:eHjjaMJfFnuFh9tIXkVg5g


# You can replace this text with custom content, and it will be preserved on regeneration
1;
