package SmallRNA::DB::StockCvterm;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("stock_cvterm");
__PACKAGE__->add_columns(
  "stock_cvterm_id",
  {
    data_type => "integer",
    default_value => "nextval('stock_cvterm_stock_cvterm_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "stock_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "cvterm_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "pub_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("stock_cvterm_id");
__PACKAGE__->add_unique_constraint("stock_cvterm_pkey", ["stock_cvterm_id"]);
__PACKAGE__->add_unique_constraint("stock_cvterm_c1", ["stock_id", "cvterm_id", "pub_id"]);
__PACKAGE__->belongs_to("stock", "SmallRNA::DB::Stock", { stock_id => "stock_id" });
__PACKAGE__->belongs_to("cvterm", "SmallRNA::DB::Cvterm", { cvterm_id => "cvterm_id" });
__PACKAGE__->belongs_to("pub", "SmallRNA::DB::Pub", { pub_id => "pub_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qXNlB8K2Dnfc7351bIGHFA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
