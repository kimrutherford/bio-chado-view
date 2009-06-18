package ChadoView::DB::FeatureRelationshipprop;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("feature_relationshipprop");
__PACKAGE__->add_columns(
  "feature_relationshipprop_id",
  {
    data_type => "integer",
    default_value => "nextval('feature_relationshipprop_feature_relationshipprop_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "feature_relationship_id",
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
__PACKAGE__->set_primary_key("feature_relationshipprop_id");
__PACKAGE__->add_unique_constraint(
  "feature_relationshipprop_c1",
  ["feature_relationship_id", "type_id", "rank"],
);
__PACKAGE__->add_unique_constraint(
  "feature_relationshipprop_pkey",
  ["feature_relationshipprop_id"],
);
__PACKAGE__->belongs_to(
  "feature_relationship",
  "ChadoView::DB::FeatureRelationship",
  { "feature_relationship_id" => "feature_relationship_id" },
);
__PACKAGE__->belongs_to("type", "ChadoView::DB::Cvterm", { cvterm_id => "type_id" });
__PACKAGE__->has_many(
  "feature_relationshipprop_pubs",
  "ChadoView::DB::FeatureRelationshippropPub",
  {
    "foreign.feature_relationshipprop_id" => "self.feature_relationshipprop_id",
  },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:VulcYzEsqBkXpULTiDwqzQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
