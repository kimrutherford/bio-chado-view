package SmallRNA::DB::FeatureCvterm;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("feature_cvterm");
__PACKAGE__->add_columns(
  "feature_cvterm_id",
  {
    data_type => "integer",
    default_value => "nextval('feature_cvterm_feature_cvterm_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "feature_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "cvterm_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "pub_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "is_not",
  {
    data_type => "boolean",
    default_value => "false",
    is_nullable => 0,
    size => 1,
  },
);
__PACKAGE__->set_primary_key("feature_cvterm_id");
__PACKAGE__->add_unique_constraint("feature_cvterm_pkey", ["feature_cvterm_id"]);
__PACKAGE__->add_unique_constraint(
  "feature_cvterm_feature_id_key",
  ["feature_id", "cvterm_id", "pub_id"],
);
__PACKAGE__->belongs_to("pub", "SmallRNA::DB::Pub", { pub_id => "pub_id" });
__PACKAGE__->belongs_to(
  "feature",
  "SmallRNA::DB::Feature",
  { feature_id => "feature_id" },
);
__PACKAGE__->belongs_to("cvterm", "SmallRNA::DB::Cvterm", { cvterm_id => "cvterm_id" });
__PACKAGE__->has_many(
  "feature_cvterm_dbxrefs",
  "SmallRNA::DB::FeatureCvtermDbxref",
  { "foreign.feature_cvterm_id" => "self.feature_cvterm_id" },
);
__PACKAGE__->has_many(
  "feature_cvtermprops",
  "SmallRNA::DB::FeatureCvtermprop",
  { "foreign.feature_cvterm_id" => "self.feature_cvterm_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RlCzwgh3gbRrnSu3FO46xQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
