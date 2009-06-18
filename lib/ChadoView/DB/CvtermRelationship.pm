package ChadoView::DB::CvtermRelationship;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("cvterm_relationship");
__PACKAGE__->add_columns(
  "cvterm_relationship_id",
  {
    data_type => "integer",
    default_value => "nextval('cvterm_relationship_cvterm_relationship_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "type_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "subject_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "object_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("cvterm_relationship_id");
__PACKAGE__->add_unique_constraint("cvterm_relationship_pkey", ["cvterm_relationship_id"]);
__PACKAGE__->add_unique_constraint(
  "cvterm_relationship_type_id_key",
  ["type_id", "subject_id", "object_id"],
);
__PACKAGE__->belongs_to(
  "object",
  "ChadoView::DB::Cvterm",
  { cvterm_id => "object_id" },
);
__PACKAGE__->belongs_to("type", "ChadoView::DB::Cvterm", { cvterm_id => "type_id" });
__PACKAGE__->belongs_to(
  "subject",
  "ChadoView::DB::Cvterm",
  { cvterm_id => "subject_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0+4lydOqOldXEX0tAmIaGQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
