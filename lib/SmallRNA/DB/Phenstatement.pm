package SmallRNA::DB::Phenstatement;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("phenstatement");
__PACKAGE__->add_columns(
  "phenstatement_id",
  {
    data_type => "integer",
    default_value => "nextval('phenstatement_phenstatement_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "genotype_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "environment_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "phenotype_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "type_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "pub_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("phenstatement_id");
__PACKAGE__->add_unique_constraint("phenstatement_pkey", ["phenstatement_id"]);
__PACKAGE__->add_unique_constraint(
  "phenstatement_c1",
  [
    "genotype_id",
    "phenotype_id",
    "environment_id",
    "type_id",
    "pub_id",
  ],
);
__PACKAGE__->belongs_to(
  "genotype",
  "SmallRNA::DB::Genotype",
  { genotype_id => "genotype_id" },
);
__PACKAGE__->belongs_to("pub", "SmallRNA::DB::Pub", { pub_id => "pub_id" });
__PACKAGE__->belongs_to(
  "environment",
  "SmallRNA::DB::Environment",
  { environment_id => "environment_id" },
);
__PACKAGE__->belongs_to("type", "SmallRNA::DB::Cvterm", { cvterm_id => "type_id" });
__PACKAGE__->belongs_to(
  "phenotype",
  "SmallRNA::DB::Phenotype",
  { phenotype_id => "phenotype_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:fPUvvc98gWewgg3sNUlu0A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
