package ChadoView::DB::PhenotypeCvterm;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("phenotype_cvterm");
__PACKAGE__->add_columns(
  "phenotype_cvterm_id",
  {
    data_type => "integer",
    default_value => "nextval('phenotype_cvterm_phenotype_cvterm_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "phenotype_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "cvterm_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "rank",
  { data_type => "integer", default_value => 0, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("phenotype_cvterm_id");
__PACKAGE__->add_unique_constraint("phenotype_cvterm_c1", ["phenotype_id", "cvterm_id", "rank"]);
__PACKAGE__->add_unique_constraint("phenotype_cvterm_pkey", ["phenotype_cvterm_id"]);
__PACKAGE__->belongs_to(
  "phenotype",
  "ChadoView::DB::Phenotype",
  { phenotype_id => "phenotype_id" },
);
__PACKAGE__->belongs_to(
  "cvterm",
  "ChadoView::DB::Cvterm",
  { cvterm_id => "cvterm_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6h7wp20UtAZmAlyQCs+ipw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
