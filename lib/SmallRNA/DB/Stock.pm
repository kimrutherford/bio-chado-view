package SmallRNA::DB::Stock;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("stock");
__PACKAGE__->add_columns(
  "stock_id",
  {
    data_type => "integer",
    default_value => "nextval('stock_stock_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "dbxref_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "organism_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
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
  "description",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "type_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "is_obsolete",
  {
    data_type => "boolean",
    default_value => "false",
    is_nullable => 0,
    size => 1,
  },
);
__PACKAGE__->set_primary_key("stock_id");
__PACKAGE__->add_unique_constraint("stock_pkey", ["stock_id"]);
__PACKAGE__->add_unique_constraint("stock_c1", ["organism_id", "uniquename", "type_id"]);
__PACKAGE__->belongs_to("dbxref", "SmallRNA::DB::Dbxref", { dbxref_id => "dbxref_id" });
__PACKAGE__->belongs_to("type", "SmallRNA::DB::Cvterm", { cvterm_id => "type_id" });
__PACKAGE__->belongs_to(
  "organism",
  "SmallRNA::DB::Organism",
  { organism_id => "organism_id" },
);
__PACKAGE__->has_many(
  "stockcollection_stocks",
  "SmallRNA::DB::StockcollectionStock",
  { "foreign.stock_id" => "self.stock_id" },
);
__PACKAGE__->has_many(
  "stock_cvterms",
  "SmallRNA::DB::StockCvterm",
  { "foreign.stock_id" => "self.stock_id" },
);
__PACKAGE__->has_many(
  "stock_dbxrefs",
  "SmallRNA::DB::StockDbxref",
  { "foreign.stock_id" => "self.stock_id" },
);
__PACKAGE__->has_many(
  "stock_genotypes",
  "SmallRNA::DB::StockGenotype",
  { "foreign.stock_id" => "self.stock_id" },
);
__PACKAGE__->has_many(
  "stockprops",
  "SmallRNA::DB::Stockprop",
  { "foreign.stock_id" => "self.stock_id" },
);
__PACKAGE__->has_many(
  "stock_pubs",
  "SmallRNA::DB::StockPub",
  { "foreign.stock_id" => "self.stock_id" },
);
__PACKAGE__->has_many(
  "stock_relationship_subject_ids",
  "SmallRNA::DB::StockRelationship",
  { "foreign.subject_id" => "self.stock_id" },
);
__PACKAGE__->has_many(
  "stock_relationship_object_ids",
  "SmallRNA::DB::StockRelationship",
  { "foreign.object_id" => "self.stock_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NcDE5BpU+1evdNVacU7Eew


# You can replace this text with custom content, and it will be preserved on regeneration
1;
