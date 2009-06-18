package SmallRNA::DB::LibrarySynonym;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("library_synonym");
__PACKAGE__->add_columns(
  "library_synonym_id",
  {
    data_type => "integer",
    default_value => "nextval('library_synonym_library_synonym_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "synonym_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "library_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "pub_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "is_current",
  {
    data_type => "boolean",
    default_value => "true",
    is_nullable => 0,
    size => 1,
  },
  "is_internal",
  {
    data_type => "boolean",
    default_value => "false",
    is_nullable => 0,
    size => 1,
  },
);
__PACKAGE__->set_primary_key("library_synonym_id");
__PACKAGE__->add_unique_constraint("library_synonym_c1", ["synonym_id", "library_id", "pub_id"]);
__PACKAGE__->add_unique_constraint("library_synonym_pkey", ["library_synonym_id"]);
__PACKAGE__->belongs_to("pub", "SmallRNA::DB::Pub", { pub_id => "pub_id" });
__PACKAGE__->belongs_to(
  "synonym",
  "SmallRNA::DB::Synonym",
  { synonym_id => "synonym_id" },
);
__PACKAGE__->belongs_to(
  "library",
  "SmallRNA::DB::Library",
  { library_id => "library_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:fId2SpLrlb1OfZvLQNpvVQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
