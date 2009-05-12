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
__PACKAGE__->add_unique_constraint("organism_id_pk", ["organism_id"]);
__PACKAGE__->has_many(
  "ecotypes",
  "SmallRNA::DB::Ecotype",
  { "foreign.organism" => "self.organism_id" },
);
__PACKAGE__->has_many(
  "genotypes",
  "SmallRNA::DB::Genotype",
  { "foreign.organism" => "self.organism_id" },
);
__PACKAGE__->has_many(
  "tissues",
  "SmallRNA::DB::Tissue",
  { "foreign.organism" => "self.organism_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1CA4dqROOB7M6yN8A6J6kg

# the genus and species, used when displaying organisms
sub full_name {
  my $self = shift;

  return $self->genus() . ' ' . $self->species();
}

# You can replace this text with custom content, and it will be preserved on regeneration
1;
