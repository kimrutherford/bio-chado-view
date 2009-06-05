package SmallRNA::DB::CodedSample;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("coded_sample");
__PACKAGE__->add_columns(
  "coded_sample_id",
  {
    data_type => "integer",
    default_value => "nextval('coded_sample_coded_sample_id_seq'::regclass)",
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
  "coded_sample_type",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "sample",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "sequencing_sample",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "barcode",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
);
__PACKAGE__->set_primary_key("coded_sample_id");
__PACKAGE__->add_unique_constraint("coded_sample_id_pk", ["coded_sample_id"]);
__PACKAGE__->belongs_to(
  "sequencing_sample",
  "SmallRNA::DB::SequencingSample",
  { sequencing_sample_id => "sequencing_sample" },
);
__PACKAGE__->belongs_to("sample", "SmallRNA::DB::Sample", { sample_id => "sample" });
__PACKAGE__->belongs_to(
  "coded_sample_type",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "coded_sample_type" },
);
__PACKAGE__->belongs_to(
  "barcode",
  "SmallRNA::DB::Barcode",
  { barcode_id => "barcode" },
);


# Created by DBIx::Class::Schema::Loader v0.04005
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:lMng83OPuqUplmwj1RkWwg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
