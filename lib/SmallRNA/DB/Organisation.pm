package SmallRNA::DB::Organisation;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("organisation");
__PACKAGE__->add_columns(
  "organisation_id",
  {
    data_type => "integer",
    default_value => "nextval('organisation_organisation_id_seq'::regclass)",
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
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("organisation_id");
__PACKAGE__->add_unique_constraint("organisation_id_pk", ["organisation_id"]);
__PACKAGE__->has_many(
  "people",
  "SmallRNA::DB::Person",
  { "foreign.organisation" => "self.organisation_id" },
);
__PACKAGE__->has_many(
  "pipeprojects",
  "SmallRNA::DB::Pipeproject",
  { "foreign.funder" => "self.organisation_id" },
);
__PACKAGE__->has_many(
  "sequencingruns",
  "SmallRNA::DB::Sequencingrun",
  { "foreign.sequencing_centre" => "self.organisation_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:D7HFV80tf2RaiWuwRRptwg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
