package SmallRNA::DB::Pipeproject;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("pipeproject");
__PACKAGE__->add_columns(
  "pipeproject_id",
  {
    data_type => "integer",
    default_value => "nextval('pipeproject_pipeproject_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "created_stamp",
  {
    data_type => "timestamp without time zone",
    default_value => "now()",
    is_nullable => 0,
    size => 8,
  },
  "name",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "description",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "type",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "owner",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "funder",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
);
__PACKAGE__->set_primary_key("pipeproject_id");
__PACKAGE__->add_unique_constraint("pipeproject_id_pk", ["pipeproject_id"]);
__PACKAGE__->belongs_to(
  "funder",
  "SmallRNA::DB::Organisation",
  { organisation_id => "funder" },
);
__PACKAGE__->belongs_to("type", "SmallRNA::DB::Cvterm", { cvterm_id => "type" });
__PACKAGE__->belongs_to("owner", "SmallRNA::DB::Person", { person_id => "owner" });
__PACKAGE__->has_many(
  "samples",
  "SmallRNA::DB::Sample",
  { "foreign.pipeproject" => "self.pipeproject_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1kaNgfwkqjovMram+vrFBw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
