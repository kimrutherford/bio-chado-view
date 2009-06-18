package ChadoView::DB::FeatureRelationship;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("feature_relationship");
__PACKAGE__->add_columns(
  "feature_relationship_id",
  {
    data_type => "integer",
    default_value => "nextval('feature_relationship_feature_relationship_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "subject_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "object_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "type_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "rank",
  { data_type => "integer", default_value => 0, is_nullable => 0, size => 4 },
  "value",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("feature_relationship_id");
__PACKAGE__->add_unique_constraint("feature_relationship_pkey", ["feature_relationship_id"]);
__PACKAGE__->add_unique_constraint(
  "feature_relationship_c1",
  ["subject_id", "object_id", "type_id", "rank"],
);
__PACKAGE__->belongs_to("type", "ChadoView::DB::Cvterm", { cvterm_id => "type_id" });
__PACKAGE__->belongs_to(
  "subject",
  "ChadoView::DB::Feature",
  { feature_id => "subject_id" },
);
__PACKAGE__->belongs_to(
  "object",
  "ChadoView::DB::Feature",
  { feature_id => "object_id" },
);
__PACKAGE__->has_many(
  "feature_relationshipprops",
  "ChadoView::DB::FeatureRelationshipprop",
  {
    "foreign.feature_relationship_id" => "self.feature_relationship_id",
  },
);
__PACKAGE__->has_many(
  "feature_relationship_pubs",
  "ChadoView::DB::FeatureRelationshipPub",
  {
    "foreign.feature_relationship_id" => "self.feature_relationship_id",
  },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wKIeGmqLOUHW3Gggg0Vr9g


# You can replace this text with custom content, and it will be preserved on regeneration
1;
