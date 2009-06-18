package ChadoView::DB::Library;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("library");
__PACKAGE__->add_columns(
  "library_id",
  {
    data_type => "integer",
    default_value => "nextval('library_library_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "organism_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "name",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "uniquename",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "type_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "is_obsolete",
  {
    data_type => "boolean",
    default_value => "false",
    is_nullable => 0,
    size => 1,
  },
  "timeaccessioned",
  {
    data_type => "timestamp without time zone",
    default_value => "now()",
    is_nullable => 0,
    size => 8,
  },
  "timelastmodified",
  {
    data_type => "timestamp without time zone",
    default_value => "now()",
    is_nullable => 0,
    size => 8,
  },
);
__PACKAGE__->set_primary_key("library_id");
__PACKAGE__->add_unique_constraint("library_c1", ["organism_id", "uniquename", "type_id"]);
__PACKAGE__->add_unique_constraint("library_pkey", ["library_id"]);
__PACKAGE__->belongs_to(
  "organism",
  "ChadoView::DB::Organism",
  { organism_id => "organism_id" },
);
__PACKAGE__->belongs_to("type", "ChadoView::DB::Cvterm", { cvterm_id => "type_id" });
__PACKAGE__->has_many(
  "library_cvterms",
  "ChadoView::DB::LibraryCvterm",
  { "foreign.library_id" => "self.library_id" },
);
__PACKAGE__->has_many(
  "library_dbxrefs",
  "ChadoView::DB::LibraryDbxref",
  { "foreign.library_id" => "self.library_id" },
);
__PACKAGE__->has_many(
  "library_features",
  "ChadoView::DB::LibraryFeature",
  { "foreign.library_id" => "self.library_id" },
);
__PACKAGE__->has_many(
  "libraryprops",
  "ChadoView::DB::Libraryprop",
  { "foreign.library_id" => "self.library_id" },
);
__PACKAGE__->has_many(
  "library_pubs",
  "ChadoView::DB::LibraryPub",
  { "foreign.library_id" => "self.library_id" },
);
__PACKAGE__->has_many(
  "library_synonyms",
  "ChadoView::DB::LibrarySynonym",
  { "foreign.library_id" => "self.library_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vmP5PqZqaXtVUZmygrhDBw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
