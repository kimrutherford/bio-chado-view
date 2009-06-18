package SmallRNA::DB::FeatureSynonym;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("feature_synonym");
__PACKAGE__->add_columns(
  "feature_synonym_id",
  {
    data_type => "integer",
    default_value => "nextval('feature_synonym_feature_synonym_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "synonym_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "feature_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "pub_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "is_current",
  {
    data_type => "boolean",
    default_value => "true",
    is_nullable => 0,
    size => 1,
  },
  "is_internal",
  {
    data_type => "boolean",
    default_value => "false",
    is_nullable => 0,
    size => 1,
  },
);
__PACKAGE__->set_primary_key("feature_synonym_id");
__PACKAGE__->add_unique_constraint(
  "feature_synonym_synonym_id_key",
  ["synonym_id", "feature_id", "pub_id"],
);
__PACKAGE__->add_unique_constraint("feature_synonym_pkey", ["feature_synonym_id"]);
__PACKAGE__->belongs_to("pub", "SmallRNA::DB::Pub", { pub_id => "pub_id" });
__PACKAGE__->belongs_to(
  "synonym",
  "SmallRNA::DB::Synonym",
  { synonym_id => "synonym_id" },
);
__PACKAGE__->belongs_to(
  "feature",
  "SmallRNA::DB::Feature",
  { feature_id => "feature_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:WpqDc5WO6JKv66Oigee2kw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
