package ChadoView::DB::Pub;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("pub");
__PACKAGE__->add_columns(
  "pub_id",
  {
    data_type => "integer",
    default_value => "nextval('pub_pub_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "title",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "volumetitle",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "volume",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "series_name",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "issue",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "pyear",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "pages",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "miniref",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "type_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "is_obsolete",
  {
    data_type => "boolean",
    default_value => "false",
    is_nullable => 1,
    size => 1,
  },
  "publisher",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "pubplace",
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
__PACKAGE__->set_primary_key("pub_id");
__PACKAGE__->add_unique_constraint("pub_unique_key", ["uniquename"]);
__PACKAGE__->add_unique_constraint("pub_pkey", ["pub_id"]);
__PACKAGE__->has_many(
  "expression_pubs",
  "ChadoView::DB::ExpressionPub",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "feature_cvterms",
  "ChadoView::DB::FeatureCvterm",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "featureloc_pubs",
  "ChadoView::DB::FeaturelocPub",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "featuremap_pubs",
  "ChadoView::DB::FeaturemapPub",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "featureprop_pubs",
  "ChadoView::DB::FeaturepropPub",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "feature_pubs",
  "ChadoView::DB::FeaturePub",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "feature_relationshipprop_pubs",
  "ChadoView::DB::FeatureRelationshippropPub",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "feature_relationship_pubs",
  "ChadoView::DB::FeatureRelationshipPub",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "feature_synonyms",
  "ChadoView::DB::FeatureSynonym",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "library_cvterms",
  "ChadoView::DB::LibraryCvterm",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "libraryprop_pubs",
  "ChadoView::DB::LibrarypropPub",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "library_pubs",
  "ChadoView::DB::LibraryPub",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "library_synonyms",
  "ChadoView::DB::LibrarySynonym",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "phendescs",
  "ChadoView::DB::Phendesc",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "phenotype_comparisons",
  "ChadoView::DB::PhenotypeComparison",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "phenstatements",
  "ChadoView::DB::Phenstatement",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->belongs_to("type", "ChadoView::DB::Cvterm", { cvterm_id => "type_id" });
__PACKAGE__->has_many(
  "pubauthors",
  "ChadoView::DB::Pubauthor",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "pub_dbxrefs",
  "ChadoView::DB::PubDbxref",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "pubprops",
  "ChadoView::DB::Pubprop",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "pub_relationship_subject_ids",
  "ChadoView::DB::PubRelationship",
  { "foreign.subject_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "pub_relationship_object_ids",
  "ChadoView::DB::PubRelationship",
  { "foreign.object_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "stock_cvterms",
  "ChadoView::DB::StockCvterm",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "stockprop_pubs",
  "ChadoView::DB::StockpropPub",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "stock_pubs",
  "ChadoView::DB::StockPub",
  { "foreign.pub_id" => "self.pub_id" },
);
__PACKAGE__->has_many(
  "stock_relationship_pubs",
  "ChadoView::DB::StockRelationshipPub",
  { "foreign.pub_id" => "self.pub_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EYg5xdBRMnfF4ZjspXJFbg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
