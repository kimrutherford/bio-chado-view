package SmallRNA::DB::Cvterm;

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
  "SmallRNA::DB::Analysisprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->belongs_to("cv", "SmallRNA::DB::Cv", { cv_id => "cv_id" });
__PACKAGE__->belongs_to("dbxref", "SmallRNA::DB::Dbxref", { dbxref_id => "dbxref_id" });
__PACKAGE__->has_many(
  "cvterm_dbxrefs",
  "SmallRNA::DB::CvtermDbxref",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "cvtermpath_object_ids",
  "SmallRNA::DB::Cvtermpath",
  { "foreign.object_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "cvtermpath_type_ids",
  "SmallRNA::DB::Cvtermpath",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "cvtermpath_subject_ids",
  "SmallRNA::DB::Cvtermpath",
  { "foreign.subject_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "cvtermprop_cvterm_ids",
  "SmallRNA::DB::Cvtermprop",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "cvtermprop_type_ids",
  "SmallRNA::DB::Cvtermprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "cvterm_relationship_object_ids",
  "SmallRNA::DB::CvtermRelationship",
  { "foreign.object_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "cvterm_relationship_type_ids",
  "SmallRNA::DB::CvtermRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "cvterm_relationship_subject_ids",
  "SmallRNA::DB::CvtermRelationship",
  { "foreign.subject_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "cvtermsynonym_cvterm_ids",
  "SmallRNA::DB::Cvtermsynonym",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "cvtermsynonym_type_ids",
  "SmallRNA::DB::Cvtermsynonym",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "dbxrefprops",
  "SmallRNA::DB::Dbxrefprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "environment_cvterms",
  "SmallRNA::DB::EnvironmentCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "expression_cvterms",
  "SmallRNA::DB::ExpressionCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "features",
  "SmallRNA::DB::Feature",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "feature_cvterms",
  "SmallRNA::DB::FeatureCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "feature_cvtermprops",
  "SmallRNA::DB::FeatureCvtermprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "feature_genotypes",
  "SmallRNA::DB::FeatureGenotype",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "featuremaps",
  "SmallRNA::DB::Featuremap",
  { "foreign.unittype_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "featureprops",
  "SmallRNA::DB::Featureprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "feature_pubprops",
  "SmallRNA::DB::FeaturePubprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "feature_relationships",
  "SmallRNA::DB::FeatureRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "feature_relationshipprops",
  "SmallRNA::DB::FeatureRelationshipprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "libraries",
  "SmallRNA::DB::Library",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "library_cvterms",
  "SmallRNA::DB::LibraryCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "libraryprops",
  "SmallRNA::DB::Libraryprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "organismprops",
  "SmallRNA::DB::Organismprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "phendescs",
  "SmallRNA::DB::Phendesc",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "phenotype_cvalue_ids",
  "SmallRNA::DB::Phenotype",
  { "foreign.cvalue_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "phenotype_observable_ids",
  "SmallRNA::DB::Phenotype",
  { "foreign.observable_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "phenotype_attr_ids",
  "SmallRNA::DB::Phenotype",
  { "foreign.attr_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "phenotype_assay_ids",
  "SmallRNA::DB::Phenotype",
  { "foreign.assay_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "phenotype_comparison_cvterms",
  "SmallRNA::DB::PhenotypeComparisonCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "phenotype_cvterms",
  "SmallRNA::DB::PhenotypeCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "phenstatements",
  "SmallRNA::DB::Phenstatement",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "pubs",
  "SmallRNA::DB::Pub",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "pubprops",
  "SmallRNA::DB::Pubprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "pub_relationships",
  "SmallRNA::DB::PubRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "stocks",
  "SmallRNA::DB::Stock",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "stockcollections",
  "SmallRNA::DB::Stockcollection",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "stockcollectionprops",
  "SmallRNA::DB::Stockcollectionprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "stock_cvterms",
  "SmallRNA::DB::StockCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "stockprops",
  "SmallRNA::DB::Stockprop",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "stock_relationships",
  "SmallRNA::DB::StockRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
);
__PACKAGE__->has_many(
  "synonyms",
  "SmallRNA::DB::Synonym",
  { "foreign.type_id" => "self.cvterm_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6D3hTJEamnKkibZjTF/UDQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
