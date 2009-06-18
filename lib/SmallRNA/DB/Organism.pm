package SmallRNA::DB::Organism;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("organism");
__PACKAGE__->add_columns(
  "organism_id",
  {
    data_type => "integer",
    default_value => "nextval('organism_organism_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "abbreviation",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "genus",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 255,
  },
  "species",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 255,
  },
  "common_name",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "comment",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("organism_id");
__PACKAGE__->add_unique_constraint("organism_pkey", ["organism_id"]);
__PACKAGE__->add_unique_constraint("organism_genus_key", ["genus", "species"]);
__PACKAGE__->has_many(
  "features",
  "SmallRNA::DB::Feature",
  { "foreign.organism_id" => "self.organism_id" },
);
__PACKAGE__->has_many(
  "libraries",
  "SmallRNA::DB::Library",
  { "foreign.organism_id" => "self.organism_id" },
);
__PACKAGE__->has_many(
  "organism_dbxrefs",
  "SmallRNA::DB::OrganismDbxref",
  { "foreign.organism_id" => "self.organism_id" },
);
__PACKAGE__->has_many(
  "organismprops",
  "SmallRNA::DB::Organismprop",
  { "foreign.organism_id" => "self.organism_id" },
);
__PACKAGE__->has_many(
  "phenotype_comparisons",
  "SmallRNA::DB::PhenotypeComparison",
  { "foreign.organism_id" => "self.organism_id" },
);
__PACKAGE__->has_many(
  "stocks",
  "SmallRNA::DB::Stock",
  { "foreign.organism_id" => "self.organism_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2oG8aaU6Xg7HU0ZXHvJUFQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
