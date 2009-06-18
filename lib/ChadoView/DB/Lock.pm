package ChadoView::DB::Lock;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("lock");
__PACKAGE__->add_columns(
  "lock_id",
  {
    data_type => "integer",
    default_value => "nextval('lock_lock_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "username",
  {
    data_type => "character varying",
    default_value => "'administrator'::character varying",
    is_nullable => 0,
    size => 20,
  },
  "locktype",
  {
    data_type => "character varying",
    default_value => "'write'::character varying",
    is_nullable => 0,
    size => 20,
  },
  "lockname",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 100,
  },
  "lockrank",
  { data_type => "integer", default_value => 0, is_nullable => 0, size => 4 },
  "lockstatus",
  {
    data_type => "boolean",
    default_value => "false",
    is_nullable => 0,
    size => 1,
  },
  "timeaccessioend",
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
  "chadoxmlfile",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "comment",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "task",
  {
    data_type => "character varying",
    default_value => "'modify gene model'::character varying",
    is_nullable => 0,
    size => 50,
  },
);
__PACKAGE__->set_primary_key("lock_id");
__PACKAGE__->add_unique_constraint("lock_pkey", ["lock_id"]);
__PACKAGE__->add_unique_constraint("lock_lockname_key", ["lockname", "lockrank", "locktype"]);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:FMyQ2MxrKvAnr+xsvJl4kQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
