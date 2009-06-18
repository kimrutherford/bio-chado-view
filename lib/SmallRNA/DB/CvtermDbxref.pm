package SmallRNA::DB::CvtermDbxref;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("cvterm_dbxref");
__PACKAGE__->add_columns(
  "cvterm_dbxref_id",
  {
    data_type => "integer",
    default_value => "nextval('cvterm_dbxref_cvterm_dbxref_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "cvterm_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "dbxref_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "is_for_definition",
  { data_type => "integer", default_value => 0, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("cvterm_dbxref_id");
__PACKAGE__->add_unique_constraint("cvterm_dbxref_cvterm_id_key", ["cvterm_id", "dbxref_id"]);
__PACKAGE__->add_unique_constraint("cvterm_dbxref_pkey", ["cvterm_dbxref_id"]);
__PACKAGE__->belongs_to("cvterm", "SmallRNA::DB::Cvterm", { cvterm_id => "cvterm_id" });
__PACKAGE__->belongs_to("dbxref", "SmallRNA::DB::Dbxref", { dbxref_id => "dbxref_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:DAft0nltMjdD1soFjWMV7Q


# You can replace this text with custom content, and it will be preserved on regeneration
1;
