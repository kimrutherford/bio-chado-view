package SmallRNA::DB::Feature;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("feature");
__PACKAGE__->add_columns(
  "feature_id",
  {
    data_type => "integer",
    default_value => "nextval('feature_feature_id_seq'::regclass)",
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
  "residues",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "seqlen",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "md5checksum",
  {
    data_type => "character",
    default_value => undef,
    is_nullable => 1,
    size => 32,
  },
  "type_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "is_analysis",
  {
    data_type => "boolean",
    default_value => "false",
    is_nullable => 0,
    size => 1,
  },
  "timeaccessioned",
  {
    data_type => "timestamp without time zone",
    default_value => "('now'::text)::timestamp(6) with time zone",
    is_nullable => 0,
    size => 8,
  },
  "timelastmodified",
  {
    data_type => "timestamp without time zone",
    default_value => "('now'::text)::timestamp(6) with time zone",
    is_nullable => 0,
    size => 8,
  },
  "is_obsolete",
  {
    data_type => "boolean",
    default_value => "false",
    is_nullable => 0,
    size => 1,
  },
);
__PACKAGE__->set_primary_key("feature_id");
__PACKAGE__->add_unique_constraint("feature_pkey", ["feature_id"]);
__PACKAGE__->add_unique_constraint(
  "feature_organism_id_key",
  ["organism_id", "uniquename", "type_id"],
);
__PACKAGE__->has_many(
  "analysisfeatures",
  "SmallRNA::DB::Analysisfeature",
  { "foreign.feature_id" => "self.feature_id" },
);
__PACKAGE__->belongs_to("type", "SmallRNA::DB::Cvterm", { cvterm_id => "type_id" });
__PACKAGE__->belongs_to("dbxref", "SmallRNA::DB::Dbxref", { dbxref_id => "dbxref_id" });
__PACKAGE__->belongs_to(
  "organism",
  "SmallRNA::DB::Organism",
  { organism_id => "organism_id" },
);
__PACKAGE__->has_many(
  "feature_cvterms",
  "SmallRNA::DB::FeatureCvterm",
  { "foreign.feature_id" => "self.feature_id" },
);
__PACKAGE__->has_many(
  "feature_dbxrefs",
  "SmallRNA::DB::FeatureDbxref",
  { "foreign.feature_id" => "self.feature_id" },
);
__PACKAGE__->has_many(
  "feature_expressions",
  "SmallRNA::DB::FeatureExpression",
  { "foreign.feature_id" => "self.feature_id" },
);
__PACKAGE__->has_many(
  "feature_genotype_chromosome_ids",
  "SmallRNA::DB::FeatureGenotype",
  { "foreign.chromosome_id" => "self.feature_id" },
);
__PACKAGE__->has_many(
  "feature_genotype_feature_ids",
  "SmallRNA::DB::FeatureGenotype",
  { "foreign.feature_id" => "self.feature_id" },
);
__PACKAGE__->has_many(
  "featureloc_feature_ids",
  "SmallRNA::DB::Featureloc",
  { "foreign.feature_id" => "self.feature_id" },
);
__PACKAGE__->has_many(
  "featureloc_srcfeature_ids",
  "SmallRNA::DB::Featureloc",
  { "foreign.srcfeature_id" => "self.feature_id" },
);
__PACKAGE__->has_many(
  "feature_phenotypes",
  "SmallRNA::DB::FeaturePhenotype",
  { "foreign.feature_id" => "self.feature_id" },
);
__PACKAGE__->has_many(
  "featurepos_map_feature_ids",
  "SmallRNA::DB::Featurepos",
  { "foreign.map_feature_id" => "self.feature_id" },
);
__PACKAGE__->has_many(
  "featurepos_feature_ids",
  "SmallRNA::DB::Featurepos",
  { "foreign.feature_id" => "self.feature_id" },
);
__PACKAGE__->has_many(
  "featureprops",
  "SmallRNA::DB::Featureprop",
  { "foreign.feature_id" => "self.feature_id" },
);
__PACKAGE__->has_many(
  "feature_pubs",
  "SmallRNA::DB::FeaturePub",
  { "foreign.feature_id" => "self.feature_id" },
);
__PACKAGE__->has_many(
  "featurerange_leftstartf_ids",
  "SmallRNA::DB::Featurerange",
  { "foreign.leftstartf_id" => "self.feature_id" },
);
__PACKAGE__->has_many(
  "featurerange_rightendf_ids",
  "SmallRNA::DB::Featurerange",
  { "foreign.rightendf_id" => "self.feature_id" },
);
__PACKAGE__->has_many(
  "featurerange_rightstartf_ids",
  "SmallRNA::DB::Featurerange",
  { "foreign.rightstartf_id" => "self.feature_id" },
);
__PACKAGE__->has_many(
  "featurerange_feature_ids",
  "SmallRNA::DB::Featurerange",
  { "foreign.feature_id" => "self.feature_id" },
);
__PACKAGE__->has_many(
  "featurerange_leftendf_ids",
  "SmallRNA::DB::Featurerange",
  { "foreign.leftendf_id" => "self.feature_id" },
);
__PACKAGE__->has_many(
  "feature_relationship_subject_ids",
  "SmallRNA::DB::FeatureRelationship",
  { "foreign.subject_id" => "self.feature_id" },
);
__PACKAGE__->has_many(
  "feature_relationship_object_ids",
  "SmallRNA::DB::FeatureRelationship",
  { "foreign.object_id" => "self.feature_id" },
);
__PACKAGE__->has_many(
  "feature_synonyms",
  "SmallRNA::DB::FeatureSynonym",
  { "foreign.feature_id" => "self.feature_id" },
);
__PACKAGE__->has_many(
  "library_features",
  "SmallRNA::DB::LibraryFeature",
  { "foreign.feature_id" => "self.feature_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RxYcXq6NdnPeJqvzvbpktw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
