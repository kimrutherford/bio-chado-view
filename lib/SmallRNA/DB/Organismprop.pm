package SmallRNA::DB::Organismprop;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("organismprop");
__PACKAGE__->add_columns(
  "organismprop_id",
  {
    data_type => "integer",
    default_value => "nextval('organismprop_organismprop_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "organism_id",
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
__PACKAGE__->set_primary_key("organismprop_id");
__PACKAGE__->add_unique_constraint("organismprop_pkey", ["organismprop_id"]);
__PACKAGE__->add_unique_constraint(
  "organismprop_organism_id_key",
  ["organism_id", "type_id", "value", "rank"],
);
__PACKAGE__->belongs_to(
  "organism",
  "SmallRNA::DB::Organism",
  { organism_id => "organism_id" },
);
__PACKAGE__->belongs_to("type", "SmallRNA::DB::Cvterm", { cvterm_id => "type_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:r+1ikV0B6nV+/HLDMvuw3w


# You can replace this text with custom content, and it will be preserved on regeneration
1;
