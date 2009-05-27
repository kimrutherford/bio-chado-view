package SmallRNA::DB::Samplerun;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("samplerun");
__PACKAGE__->add_columns(
  "samplerun_id",
  {
    data_type => "integer",
    default_value => "nextval('samplerun_samplerun_id_seq'::regclass)",
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
  "description",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "samplerun_type",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "sample",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "barcode",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "sequencingrun",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("samplerun_id");
__PACKAGE__->add_unique_constraint("samplerun_id_pk", ["samplerun_id"]);
__PACKAGE__->belongs_to(
  "samplerun_type",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "samplerun_type" },
);
__PACKAGE__->belongs_to(
  "sequencingrun",
  "SmallRNA::DB::Sequencingrun",
  { sequencingrun_id => "sequencingrun" },
);
__PACKAGE__->belongs_to(
  "barcode",
  "SmallRNA::DB::Barcode",
  { barcode_id => "barcode" },
);
__PACKAGE__->belongs_to("sample", "SmallRNA::DB::Sample", { sample_id => "sample" });


# Created by DBIx::Class::Schema::Loader v0.04005
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:68Yda2ouIcKrQhWmTBehxg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
