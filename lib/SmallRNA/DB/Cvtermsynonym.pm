package SmallRNA::DB::Cvtermsynonym;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("cvtermsynonym");
__PACKAGE__->add_columns(
  "cvtermsynonym_id",
  {
    data_type => "integer",
    default_value => "nextval('cvtermsynonym_cvtermsynonym_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "cvterm_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "name",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 1024,
  },
  "type_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
);
__PACKAGE__->set_primary_key("cvtermsynonym_id");
__PACKAGE__->add_unique_constraint("cvtermsynonym_pkey", ["cvtermsynonym_id"]);
__PACKAGE__->add_unique_constraint("cvtermsynonym_cvterm_id_key", ["cvterm_id", "name"]);
__PACKAGE__->belongs_to("cvterm", "SmallRNA::DB::Cvterm", { cvterm_id => "cvterm_id" });
__PACKAGE__->belongs_to("type", "SmallRNA::DB::Cvterm", { cvterm_id => "type_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xDDSJZ0mfj9YQtN++SmTfA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
