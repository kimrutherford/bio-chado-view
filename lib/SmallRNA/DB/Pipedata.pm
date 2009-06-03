package SmallRNA::DB::Pipedata;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("pipedata");
__PACKAGE__->add_columns(
  "pipedata_id",
  {
    data_type => "integer",
    default_value => "nextval('pipedata_pipedata_id_seq'::regclass)",
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
  "format_type",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "content_type",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "file_name",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "file_length",
  { data_type => "bigint", default_value => undef, is_nullable => 0, size => 8 },
  "generating_pipeprocess",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
);
__PACKAGE__->set_primary_key("pipedata_id");
__PACKAGE__->add_unique_constraint("pipedata_id_pk", ["pipedata_id"]);
__PACKAGE__->add_unique_constraint("pipedata_file_name_key", ["file_name"]);
__PACKAGE__->belongs_to(
  "generating_pipeprocess",
  "SmallRNA::DB::Pipeprocess",
  { pipeprocess_id => "generating_pipeprocess" },
);
__PACKAGE__->belongs_to(
  "format_type",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "format_type" },
);
__PACKAGE__->belongs_to(
  "content_type",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "content_type" },
);
__PACKAGE__->has_many(
  "pipeprocess_in_pipedatas",
  "SmallRNA::DB::PipeprocessInPipedata",
  { "foreign.pipedata" => "self.pipedata_id" },
);
__PACKAGE__->has_many(
  "sample_pipedatas",
  "SmallRNA::DB::SamplePipedata",
  { "foreign.pipedata" => "self.pipedata_id" },
);
__PACKAGE__->has_many(
  "sequencingruns",
  "SmallRNA::DB::Sequencingrun",
  { "foreign.initial_pipedata" => "self.pipedata_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:etXOraNBbcCdTjcTfVyRRA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
