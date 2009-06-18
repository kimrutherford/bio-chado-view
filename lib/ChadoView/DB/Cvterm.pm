package ChadoView::DB::Cvterm;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("cvterm");
__PACKAGE__->add_columns(
  "cvterm_id",
  {
    data_type => "integer",
    default_value => "nextval('cvterm_cvterm_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "cv_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "definition",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "dbxref_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "is_obsolete",
  { data_type => "integer", default_value => 0, is_nullable => 0, size => 4 },
  "is_relationshiptype",
  { data_type => "integer", default_value => 0, is_nullable => 0, size => 4 },
  "name",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 1024,
  },
);
__PACKAGE__->set_primary_key("cvterm_id");
__PACKAGE__->add_unique_constraint("cvterm_c2_unique", ["dbxref_id"]);
__PACKAGE__->add_unique_constraint("cvterm_c1_unique", ["cv_id", "name", "is_obsolete"]);
__PACKAGE__->add_unique_constraint("cvterm_pkey", ["cvterm_id"]);
__PACKAGE__->has_many(
  "analysisprops",
  "ChadoView::DB::Analysisprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->belongs_to("cv", "ChadoView::DB::Cv", { cv_id => "cv_id" });
__PACKAGE__->belongs_to(
  "dbxref",
  "ChadoView::DB::Dbxref",
  { dbxref_id => "dbxref_id" },
);
__PACKAGE__->has_many(
  "cvterm_dbxrefs",
  "ChadoView::DB::CvtermDbxref",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "cvtermpath_object_ids",
  "ChadoView::DB::Cvtermpath",
  { "foreign.object_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "cvtermpath_type_ids",
  "ChadoView::DB::Cvtermpath",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "cvtermpath_subject_ids",
  "ChadoView::DB::Cvtermpath",
  { "foreign.subject_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "cvtermprop_cvterm_ids",
  "ChadoView::DB::Cvtermprop",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "cvtermprop_type_ids",
  "ChadoView::DB::Cvtermprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "cvterm_relationship_object_ids",
  "ChadoView::DB::CvtermRelationship",
  { "foreign.object_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "cvterm_relationship_type_ids",
  "ChadoView::DB::CvtermRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "cvterm_relationship_subject_ids",
  "ChadoView::DB::CvtermRelationship",
  { "foreign.subject_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "cvtermsynonym_cvterm_ids",
  "ChadoView::DB::Cvtermsynonym",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "cvtermsynonym_type_ids",
  "ChadoView::DB::Cvtermsynonym",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "dbxrefprops",
  "ChadoView::DB::Dbxrefprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "environment_cvterms",
  "ChadoView::DB::EnvironmentCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "expression_cvterms",
  "ChadoView::DB::ExpressionCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "features",
  "ChadoView::DB::Feature",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "feature_cvterms",
  "ChadoView::DB::FeatureCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "feature_cvtermprops",
  "ChadoView::DB::FeatureCvtermprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "feature_genotypes",
  "ChadoView::DB::FeatureGenotype",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "featuremaps",
  "ChadoView::DB::Featuremap",
  { "foreign.unittype_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "featureprops",
  "ChadoView::DB::Featureprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "feature_pubprops",
  "ChadoView::DB::FeaturePubprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "feature_relationships",
  "ChadoView::DB::FeatureRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "feature_relationshipprops",
  "ChadoView::DB::FeatureRelationshipprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "libraries",
  "ChadoView::DB::Library",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "library_cvterms",
  "ChadoView::DB::LibraryCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "libraryprops",
  "ChadoView::DB::Libraryprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "organismprops",
  "ChadoView::DB::Organismprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "phendescs",
  "ChadoView::DB::Phendesc",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "phenotype_cvalue_ids",
  "ChadoView::DB::Phenotype",
  { "foreign.cvalue_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "phenotype_observable_ids",
  "ChadoView::DB::Phenotype",
  { "foreign.observable_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "phenotype_attr_ids",
  "ChadoView::DB::Phenotype",
  { "foreign.attr_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "phenotype_assay_ids",
  "ChadoView::DB::Phenotype",
  { "foreign.assay_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "phenotype_comparison_cvterms",
  "ChadoView::DB::PhenotypeComparisonCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "phenotype_cvterms",
  "ChadoView::DB::PhenotypeCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "phenstatements",
  "ChadoView::DB::Phenstatement",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "pubs",
  "ChadoView::DB::Pub",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "pubprops",
  "ChadoView::DB::Pubprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "pub_relationships",
  "ChadoView::DB::PubRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "stocks",
  "ChadoView::DB::Stock",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "stockcollections",
  "ChadoView::DB::Stockcollection",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "stockcollectionprops",
  "ChadoView::DB::Stockcollectionprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "stock_cvterms",
  "ChadoView::DB::StockCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "stockprops",
  "ChadoView::DB::Stockprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "stock_relationships",
  "ChadoView::DB::StockRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "synonyms",
  "ChadoView::DB::Synonym",
  { "foreign.type_id" => "self.cvterm_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JS5ibVjpXvdWQY+ffb0cVw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
