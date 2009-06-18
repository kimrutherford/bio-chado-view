package SmallRNA::DB::AuditChado;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("audit_chado");
__PACKAGE__->add_columns(
  "audit_transaction",
  {
    data_type => "character",
    default_value => undef,
    is_nullable => 0,
    size => 1,
  },
  "transaction_timestamp",
  {
    data_type => "timestamp without time zone",
    default_value => undef,
    is_nullable => 0,
    size => 8,
  },
  "userid",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 255,
  },
  "audited_table",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 255,
  },
  "record_pkey",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "record_ukey_cols",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "record_ukey_vals",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "audited_cols",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "audited_vals",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:WBUzgkGkTGE4dz3ccnWqHA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
