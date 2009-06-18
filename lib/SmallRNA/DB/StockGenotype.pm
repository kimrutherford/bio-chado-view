package SmallRNA::DB::StockGenotype;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("stock_genotype");
__PACKAGE__->add_columns(
  "stock_genotype_id",
  {
    data_type => "integer",
    default_value => "nextval('stock_genotype_stock_genotype_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "stock_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "genotype_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("stock_genotype_id");
__PACKAGE__->add_unique_constraint("stock_genotype_c1", ["stock_id", "genotype_id"]);
__PACKAGE__->add_unique_constraint("stock_genotype_pkey", ["stock_genotype_id"]);
__PACKAGE__->belongs_to("stock", "SmallRNA::DB::Stock", { stock_id => "stock_id" });
__PACKAGE__->belongs_to(
  "genotype",
  "SmallRNA::DB::Genotype",
  { genotype_id => "genotype_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:05BfTABxNVSUNMGIEJa+Aw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
