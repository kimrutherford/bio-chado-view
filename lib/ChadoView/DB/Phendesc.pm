package ChadoView::DB::Phendesc;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("phendesc");
__PACKAGE__->add_columns(
  "phendesc_id",
  {
    data_type => "integer",
    default_value => "nextval('phendesc_phendesc_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "genotype_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "environment_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "description",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "type_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "pub_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("phendesc_id");
__PACKAGE__->add_unique_constraint(
  "phendesc_c1",
  ["genotype_id", "environment_id", "type_id", "pub_id"],
);
__PACKAGE__->add_unique_constraint("phendesc_pkey", ["phendesc_id"]);
__PACKAGE__->belongs_to("type", "ChadoView::DB::Cvterm", { cvterm_id => "type_id" });
__PACKAGE__->belongs_to(
  "genotype",
  "ChadoView::DB::Genotype",
  { genotype_id => "genotype_id" },
);
__PACKAGE__->belongs_to(
  "environment",
  "ChadoView::DB::Environment",
  { environment_id => "environment_id" },
);
__PACKAGE__->belongs_to("pub", "ChadoView::DB::Pub", { pub_id => "pub_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:dJid6kIEsHAxwpmT6uIfuA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
