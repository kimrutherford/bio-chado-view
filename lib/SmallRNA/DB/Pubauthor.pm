package SmallRNA::DB::Pubauthor;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("pubauthor");
__PACKAGE__->add_columns(
  "pubauthor_id",
  {
    data_type => "integer",
    default_value => "nextval('pubauthor_pubauthor_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "pub_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "rank",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "editor",
  {
    data_type => "boolean",
    default_value => "false",
    is_nullable => 1,
    size => 1,
  },
  "surname",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 100,
  },
  "givennames",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "suffix",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
);
__PACKAGE__->set_primary_key("pubauthor_id");
__PACKAGE__->add_unique_constraint("pubauthor_c1", ["pub_id", "rank"]);
__PACKAGE__->add_unique_constraint("pubauthor_pkey", ["pubauthor_id"]);
__PACKAGE__->belongs_to("pub", "SmallRNA::DB::Pub", { pub_id => "pub_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Owop3z68RBzshuOjRxhDuA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
