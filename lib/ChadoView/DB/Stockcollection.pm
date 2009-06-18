package ChadoView::DB::Stockcollection;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("stockcollection");
__PACKAGE__->add_columns(
  "stockcollection_id",
  {
    data_type => "integer",
    default_value => "nextval('stockcollection_stockcollection_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "type_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "contact_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "name",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "uniquename",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("stockcollection_id");
__PACKAGE__->add_unique_constraint("stockcollection_c1", ["uniquename", "type_id"]);
__PACKAGE__->add_unique_constraint("stockcollection_pkey", ["stockcollection_id"]);
__PACKAGE__->belongs_to("type", "ChadoView::DB::Cvterm", { cvterm_id => "type_id" });
__PACKAGE__->belongs_to(
  "contact",
  "ChadoView::DB::Contact",
  { contact_id => "contact_id" },
);
__PACKAGE__->has_many(
  "stockcollectionprops",
  "ChadoView::DB::Stockcollectionprop",
  { "foreign.stockcollection_id" => "self.stockcollection_id" },
);
__PACKAGE__->has_many(
  "stockcollection_stocks",
  "ChadoView::DB::StockcollectionStock",
  { "foreign.stockcollection_id" => "self.stockcollection_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vbkVCN6+GlmLRXgr9HM3Zg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
