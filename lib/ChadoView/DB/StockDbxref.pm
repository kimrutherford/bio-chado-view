package ChadoView::DB::StockDbxref;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("stock_dbxref");
__PACKAGE__->add_columns(
  "stock_dbxref_id",
  {
    data_type => "integer",
    default_value => "nextval('stock_dbxref_stock_dbxref_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "stock_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "dbxref_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "is_current",
  {
    data_type => "boolean",
    default_value => "true",
    is_nullable => 0,
    size => 1,
  },
);
__PACKAGE__->set_primary_key("stock_dbxref_id");
__PACKAGE__->add_unique_constraint("stock_dbxref_pkey", ["stock_dbxref_id"]);
__PACKAGE__->add_unique_constraint("stock_dbxref_c1", ["stock_id", "dbxref_id"]);
__PACKAGE__->belongs_to(
  "dbxref",
  "ChadoView::DB::Dbxref",
  { dbxref_id => "dbxref_id" },
);
__PACKAGE__->belongs_to("stock", "ChadoView::DB::Stock", { stock_id => "stock_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:w1xFSn6a2LvEvgVQoBhl9g


# You can replace this text with custom content, and it will be preserved on regeneration
1;
