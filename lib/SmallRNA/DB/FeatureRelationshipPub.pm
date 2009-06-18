package SmallRNA::DB::FeatureRelationshipPub;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("feature_relationship_pub");
__PACKAGE__->add_columns(
  "feature_relationship_pub_id",
  {
    data_type => "integer",
    default_value => "nextval('feature_relationship_pub_feature_relationship_pub_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "feature_relationship_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "pub_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("feature_relationship_pub_id");
__PACKAGE__->add_unique_constraint(
  "feature_relationship_pub_pkey",
  ["feature_relationship_pub_id"],
);
__PACKAGE__->add_unique_constraint(
  "feature_relationship_pub_c1",
  ["feature_relationship_id", "pub_id"],
);
__PACKAGE__->belongs_to(
  "feature_relationship",
  "SmallRNA::DB::FeatureRelationship",
  { "feature_relationship_id" => "feature_relationship_id" },
);
__PACKAGE__->belongs_to("pub", "SmallRNA::DB::Pub", { pub_id => "pub_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jZlWKBBZbq6APXadOru98g


# You can replace this text with custom content, and it will be preserved on regeneration
1;
