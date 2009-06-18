package SmallRNA::DB::PubDbxref;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("pub_dbxref");
__PACKAGE__->add_columns(
  "pub_dbxref_id",
  {
    data_type => "integer",
    default_value => "nextval('pub_dbxref_pub_dbxref_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "pub_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "dbxref_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "is_current",
  {
    data_type => "boolean",
    default_value => "true",
    is_nullable => 0,
    size => 1,
  },
);
__PACKAGE__->set_primary_key("pub_dbxref_id");
__PACKAGE__->add_unique_constraint("pub_dbxref_pub_id_key", ["pub_id", "dbxref_id"]);
__PACKAGE__->add_unique_constraint("pub_dbxref_pkey", ["pub_dbxref_id"]);
__PACKAGE__->belongs_to("pub", "SmallRNA::DB::Pub", { pub_id => "pub_id" });
__PACKAGE__->belongs_to("dbxref", "SmallRNA::DB::Dbxref", { dbxref_id => "dbxref_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:aPaRYVnSnRzH266J1cYAjQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
