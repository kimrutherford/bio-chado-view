package SmallRNA::DB::FeaturePub;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("feature_pub");
__PACKAGE__->add_columns(
  "feature_pub_id",
  {
    data_type => "integer",
    default_value => "nextval('feature_pub_feature_pub_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "feature_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "pub_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("feature_pub_id");
__PACKAGE__->add_unique_constraint("feature_pub_pkey", ["feature_pub_id"]);
__PACKAGE__->add_unique_constraint("feature_pub_feature_id_key", ["feature_id", "pub_id"]);
__PACKAGE__->belongs_to(
  "feature",
  "SmallRNA::DB::Feature",
  { feature_id => "feature_id" },
);
__PACKAGE__->belongs_to("pub", "SmallRNA::DB::Pub", { pub_id => "pub_id" });
__PACKAGE__->has_many(
  "feature_pubprops",
  "SmallRNA::DB::FeaturePubprop",
  { "foreign.feature_pub_id" => "self.feature_pub_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wxjlMk2NmSnf8htFdu2AvQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
