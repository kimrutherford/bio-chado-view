package SmallRNA::DB::LibraryDbxref;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("library_dbxref");
__PACKAGE__->add_columns(
  "library_dbxref_id",
  {
    data_type => "integer",
    default_value => "nextval('library_dbxref_library_dbxref_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "library_id",
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
__PACKAGE__->set_primary_key("library_dbxref_id");
__PACKAGE__->add_unique_constraint("library_dbxref_pkey", ["library_dbxref_id"]);
__PACKAGE__->add_unique_constraint("library_dbxref_c1", ["library_id", "dbxref_id"]);
__PACKAGE__->belongs_to(
  "library",
  "SmallRNA::DB::Library",
  { library_id => "library_id" },
);
__PACKAGE__->belongs_to("dbxref", "SmallRNA::DB::Dbxref", { dbxref_id => "dbxref_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XWgYRm26Zlz1WkiUS5SrpA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
