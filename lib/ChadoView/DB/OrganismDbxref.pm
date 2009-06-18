package ChadoView::DB::OrganismDbxref;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("organism_dbxref");
__PACKAGE__->add_columns(
  "organism_dbxref_id",
  {
    data_type => "integer",
    default_value => "nextval('organism_dbxref_organism_dbxref_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "organism_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "dbxref_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("organism_dbxref_id");
__PACKAGE__->add_unique_constraint("organism_dbxref_pkey", ["organism_dbxref_id"]);
__PACKAGE__->add_unique_constraint(
  "organism_dbxref_organism_id_key",
  ["organism_id", "dbxref_id"],
);
__PACKAGE__->belongs_to(
  "organism",
  "ChadoView::DB::Organism",
  { organism_id => "organism_id" },
);
__PACKAGE__->belongs_to(
  "dbxref",
  "ChadoView::DB::Dbxref",
  { dbxref_id => "dbxref_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:PkOS65gqUHXexCuyA9Qtyw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
