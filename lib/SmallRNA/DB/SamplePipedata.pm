package SmallRNA::DB::SamplePipedata;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("sample_pipedata");
__PACKAGE__->add_columns(
  "sample_pipedata_id",
  {
    data_type => "integer",
    default_value => "nextval('sample_pipedata_sample_pipedata_id_seq'::regclass)",
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
  "sample",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "pipedata",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("sample_pipedata_id");
__PACKAGE__->add_unique_constraint("sample_pipedata_id_pk", ["sample_pipedata_id"]);
__PACKAGE__->belongs_to(
  "pipedata",
  "SmallRNA::DB::Pipedata",
  { pipedata_id => "pipedata" },
);
__PACKAGE__->belongs_to("sample", "SmallRNA::DB::Sample", { sample_id => "sample" });


# Created by DBIx::Class::Schema::Loader v0.04005
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:CoqFQ9J0UvHwBp+pL5AtWA

1;
