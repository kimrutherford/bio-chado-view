package ChadoView::DB::FeaturePubprop;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("feature_pubprop");
__PACKAGE__->add_columns(
  "feature_pubprop_id",
  {
    data_type => "integer",
    default_value => "nextval('feature_pubprop_feature_pubprop_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "feature_pub_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "type_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "value",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "rank",
  { data_type => "integer", default_value => 0, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("feature_pubprop_id");
__PACKAGE__->add_unique_constraint("feature_pubprop_pkey", ["feature_pubprop_id"]);
__PACKAGE__->add_unique_constraint("feature_pubprop_c1", ["feature_pub_id", "type_id", "rank"]);
__PACKAGE__->belongs_to(
  "feature_pub",
  "ChadoView::DB::FeaturePub",
  { feature_pub_id => "feature_pub_id" },
);
__PACKAGE__->belongs_to("type", "ChadoView::DB::Cvterm", { cvterm_id => "type_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GXbugsVrVd1YVykBjWw3sg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
