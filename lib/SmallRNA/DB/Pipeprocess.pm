package SmallRNA::DB::Pipeprocess;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("pipeprocess");
__PACKAGE__->add_columns(
  "pipeprocess_id",
  {
    data_type => "integer",
    default_value => "nextval('pipeprocess_pipeprocess_id_seq'::regclass)",
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
  "process_conf",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "status",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "job_identifier",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "time_queued",
  {
    data_type => "timestamp without time zone",
    default_value => undef,
    is_nullable => 1,
    size => 8,
  },
  "time_started",
  {
    data_type => "timestamp without time zone",
    default_value => undef,
    is_nullable => 1,
    size => 8,
  },
  "time_finished",
  {
    data_type => "timestamp without time zone",
    default_value => undef,
    is_nullable => 1,
    size => 8,
  },
);
__PACKAGE__->set_primary_key("pipeprocess_id");
__PACKAGE__->add_unique_constraint("pipeprocess_id_pk", ["pipeprocess_id"]);
__PACKAGE__->has_many(
  "pipedatas",
  "SmallRNA::DB::Pipedata",
  { "foreign.generating_pipeprocess" => "self.pipeprocess_id" },
);
__PACKAGE__->belongs_to("status", "SmallRNA::DB::Cvterm", { cvterm_id => "status" });
__PACKAGE__->belongs_to(
  "process_conf",
  "SmallRNA::DB::ProcessConf",
  { process_conf_id => "process_conf" },
);
__PACKAGE__->has_many(
  "pipeprocess_in_pipedatas",
  "SmallRNA::DB::PipeprocessInPipedata",
  { "foreign.pipeprocess" => "self.pipeprocess_id" },
);
__PACKAGE__->has_many(
  "sequencingruns",
  "SmallRNA::DB::Sequencingrun",
  { "foreign.initial_pipeprocess" => "self.pipeprocess_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1OUGvjDJlw0ZK1OdHG3+Yw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
