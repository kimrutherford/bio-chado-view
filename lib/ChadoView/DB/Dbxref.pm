package ChadoView::DB::Dbxref;

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
  "ChadoView::DB::Cvterm",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);
__PACKAGE__->has_many(
  "cvterm_dbxrefs",
  "ChadoView::DB::CvtermDbxref",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);
__PACKAGE__->belongs_to("db", "ChadoView::DB::Db", { db_id => "db_id" });
__PACKAGE__->has_many(
  "dbxrefprops",
  "ChadoView::DB::Dbxrefprop",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);
__PACKAGE__->has_many(
  "features",
  "ChadoView::DB::Feature",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);
__PACKAGE__->has_many(
  "feature_cvterm_dbxrefs",
  "ChadoView::DB::FeatureCvtermDbxref",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);
__PACKAGE__->has_many(
  "feature_dbxrefs",
  "ChadoView::DB::FeatureDbxref",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);
__PACKAGE__->has_many(
  "library_dbxrefs",
  "ChadoView::DB::LibraryDbxref",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);
__PACKAGE__->has_many(
  "organism_dbxrefs",
  "ChadoView::DB::OrganismDbxref",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);
__PACKAGE__->has_many(
  "pub_dbxrefs",
  "ChadoView::DB::PubDbxref",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);
__PACKAGE__->has_many(
  "stocks",
  "ChadoView::DB::Stock",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);
__PACKAGE__->has_many(
  "stock_dbxrefs",
  "ChadoView::DB::StockDbxref",
  { "foreign.dbxref_id" => "self.dbxref_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jw2gsxQYsNMtDeaJxC/Kkg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
