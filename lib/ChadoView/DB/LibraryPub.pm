package ChadoView::DB::LibraryPub;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("library_pub");
__PACKAGE__->add_columns(
  "library_pub_id",
  {
    data_type => "integer",
    default_value => "nextval('library_pub_library_pub_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "library_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "pub_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("library_pub_id");
__PACKAGE__->add_unique_constraint("library_pub_pkey", ["library_pub_id"]);
__PACKAGE__->add_unique_constraint("library_pub_c1", ["library_id", "pub_id"]);
__PACKAGE__->belongs_to(
  "library",
  "ChadoView::DB::Library",
  { library_id => "library_id" },
);
__PACKAGE__->belongs_to("pub", "ChadoView::DB::Pub", { pub_id => "pub_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:sZhZv7AN95PQefQJfLO9dA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
