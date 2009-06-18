package ChadoView::DB::UpdateTrack;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("update_track");
__PACKAGE__->add_columns(
  "update_track_id",
  {
    data_type => "integer",
    default_value => "nextval('update_track_update_track_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "release",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 20,
  },
  "fbid",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 50,
  },
  "time_update",
  {
    data_type => "timestamp without time zone",
    default_value => "now()",
    is_nullable => 0,
    size => 8,
  },
  "author",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 20,
  },
  "statement",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 255,
  },
  "comment",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
);
__PACKAGE__->set_primary_key("update_track_id");
__PACKAGE__->add_unique_constraint("update_track_pkey", ["update_track_id"]);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9DR1isJlOV4lcg61ht3vxg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
