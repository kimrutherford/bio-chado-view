package SmallRNA::DB::Barcode;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("barcode");
__PACKAGE__->add_columns(
  "barcode_id",
  {
    data_type => "integer",
    default_value => "nextval('barcode_barcode_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "created_stamp",
  {
    data_type => "timestamp without time zone",
    default_value => "now()",
    is_nullable => 0,
    size => 8,
  },
  "identifier",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "code",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("barcode_id");
__PACKAGE__->add_unique_constraint("barcode_id_pk", ["barcode_id"]);
__PACKAGE__->add_unique_constraint("barcode_code_key", ["code"]);
__PACKAGE__->add_unique_constraint("barcode_identifier_key", ["identifier"]);
__PACKAGE__->has_many(
  "coded_samples",
  "SmallRNA::DB::CodedSample",
  { "foreign.barcode" => "self.barcode_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2wbTkxuzQboFUUg4kuddqA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
