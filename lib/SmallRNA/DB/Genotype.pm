package SmallRNA::DB::Genotype;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("genotype");
__PACKAGE__->add_columns(
  "genotype_id",
  {
    data_type => "integer",
    default_value => "nextval('genotype_genotype_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "created_stamp",
  {
    data_type => "timestamp without time zone",
    default_value => "now()",
    is_nullable => 0,
    size => 8,
  },
  "organism",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "type",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "description",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("genotype_id");
__PACKAGE__->add_unique_constraint("genotype_id_pk", ["genotype_id"]);
__PACKAGE__->belongs_to("type", "SmallRNA::DB::Cvterm", { cvterm_id => "type" });
__PACKAGE__->belongs_to(
  "organism",
  "SmallRNA::DB::Organism",
  { organism_id => "organism" },
);
__PACKAGE__->has_many(
  "samples",
  "SmallRNA::DB::Sample",
  { "foreign.genotype" => "self.genotype_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:WdQVOO4/4tp0pHuAvAgWcQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
