package ChadoView::DB::Dbxrefprop;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("dbxrefprop");
__PACKAGE__->add_columns(
  "dbxrefprop_id",
  {
    data_type => "integer",
    default_value => "nextval('dbxrefprop_dbxrefprop_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "dbxref_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "type_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "value",
  {
    data_type => "text",
    default_value => "''::text",
    is_nullable => 0,
    size => undef,
  },
  "rank",
  { data_type => "integer", default_value => 0, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("dbxrefprop_id");
__PACKAGE__->add_unique_constraint("dbxrefprop_c1", ["dbxref_id", "type_id", "rank"]);
__PACKAGE__->add_unique_constraint("dbxrefprop_pkey", ["dbxrefprop_id"]);
__PACKAGE__->belongs_to(
  "dbxref",
  "ChadoView::DB::Dbxref",
  { dbxref_id => "dbxref_id" },
);
__PACKAGE__->belongs_to("type", "ChadoView::DB::Cvterm", { cvterm_id => "type_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:pHCEs+YiVvE5ounVcpXgHg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
