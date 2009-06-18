package SmallRNA::DB::FeatureRelationshippropPub;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("feature_relationshipprop_pub");
__PACKAGE__->add_columns(
  "feature_relationshipprop_pub_id",
  {
    data_type => "integer",
    default_value => "nextval('feature_relationshipprop_pub_feature_relationshipprop_pub_i_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "feature_relationshipprop_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "pub_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("feature_relationshipprop_pub_id");
__PACKAGE__->add_unique_constraint(
  "feature_relationshipprop_pub_pkey",
  ["feature_relationshipprop_pub_id"],
);
__PACKAGE__->add_unique_constraint(
  "feature_relationshipprop_pub_c1",
  ["feature_relationshipprop_id", "pub_id"],
);
__PACKAGE__->belongs_to(
  "feature_relationshipprop",
  "SmallRNA::DB::FeatureRelationshipprop",
  { "feature_relationshipprop_id" => "feature_relationshipprop_id" },
);
__PACKAGE__->belongs_to("pub", "SmallRNA::DB::Pub", { pub_id => "pub_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KwUGz5a3rgVvpBgFpMYXqw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
