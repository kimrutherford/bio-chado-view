package SmallRNA::DB::Tableinfo;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("tableinfo");
__PACKAGE__->add_columns(
  "tableinfo_id",
  {
    data_type => "integer",
    default_value => "nextval('tableinfo_tableinfo_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "name",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 30,
  },
  "primary_key_column",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 30,
  },
  "is_view",
  { data_type => "integer", default_value => 0, is_nullable => 0, size => 4 },
  "view_on_table_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "superclass_table_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "is_updateable",
  { data_type => "integer", default_value => 1, is_nullable => 0, size => 4 },
  "modification_date",
  { data_type => "date", default_value => "now()", is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("tableinfo_id");
__PACKAGE__->add_unique_constraint("tableinfo_pkey", ["tableinfo_id"]);
__PACKAGE__->add_unique_constraint("tableinfo_c1", ["name"]);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ZTje5BKH+vbDxNbsv0E2cg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
