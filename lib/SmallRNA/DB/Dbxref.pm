package SmallRNA::DB::Dbxref;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("dbxref");
__PACKAGE__->add_columns(
  "dbxref_id",
  {
    data_type => "integer",
    default_value => "nextval('dbxref_dbxref_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "db_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "accession",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 255,
  },
  "version",
  {
    data_type => "character varying",
    default_value => "''::character varying",
    is_nullable => 0,
    size => 255,
  },
  "description",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("dbxref_id");
__PACKAGE__->add_unique_constraint("dbxref_pkey", ["dbxref_id"]);
__PACKAGE__->add_unique_constraint("dbxref_db_id_key", ["db_id", "accession", "version"]);
__PACKAGE__->has_many(
  "cvterms",
  "SmallRNA::DB::Cvterm",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);
__PACKAGE__->has_many(
  "cvterm_dbxrefs",
  "SmallRNA::DB::CvtermDbxref",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);
__PACKAGE__->belongs_to("db", "SmallRNA::DB::Db", { db_id => "db_id" });
__PACKAGE__->has_many(
  "dbxrefprops",
  "SmallRNA::DB::Dbxrefprop",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);
__PACKAGE__->has_many(
  "features",
  "SmallRNA::DB::Feature",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);
__PACKAGE__->has_many(
  "feature_cvterm_dbxrefs",
  "SmallRNA::DB::FeatureCvtermDbxref",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);
__PACKAGE__->has_many(
  "feature_dbxrefs",
  "SmallRNA::DB::FeatureDbxref",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);
__PACKAGE__->has_many(
  "library_dbxrefs",
  "SmallRNA::DB::LibraryDbxref",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);
__PACKAGE__->has_many(
  "organism_dbxrefs",
  "SmallRNA::DB::OrganismDbxref",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);
__PACKAGE__->has_many(
  "pub_dbxrefs",
  "SmallRNA::DB::PubDbxref",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);
__PACKAGE__->has_many(
  "stocks",
  "SmallRNA::DB::Stock",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);
__PACKAGE__->has_many(
  "stock_dbxrefs",
  "SmallRNA::DB::StockDbxref",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vxCZepCoLQiejaGIX9QGEQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
