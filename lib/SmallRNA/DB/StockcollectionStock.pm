package SmallRNA::DB::StockcollectionStock;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("stockcollection_stock");
__PACKAGE__->add_columns(
  "stockcollection_stock_id",
  {
    data_type => "integer",
    default_value => "nextval('stockcollection_stock_stockcollection_stock_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "stockcollection_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "stock_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("stockcollection_stock_id");
__PACKAGE__->add_unique_constraint("stockcollection_stock_pkey", ["stockcollection_stock_id"]);
__PACKAGE__->add_unique_constraint(
  "stockcollection_stock_c1",
  ["stockcollection_id", "stock_id"],
);
__PACKAGE__->belongs_to("stock", "SmallRNA::DB::Stock", { stock_id => "stock_id" });
__PACKAGE__->belongs_to(
  "stockcollection",
  "SmallRNA::DB::Stockcollection",
  { stockcollection_id => "stockcollection_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bfh00AVpszld/s4nzFkAuQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
