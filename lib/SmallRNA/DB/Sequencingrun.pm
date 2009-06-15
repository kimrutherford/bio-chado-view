package SmallRNA::DB::Sequencingrun;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("sequencingrun");
__PACKAGE__->add_columns(
  "sequencingrun_id",
  {
    data_type => "integer",
    default_value => "nextval('sequencingrun_sequencingrun_id_seq'::regclass)",
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
  "sequencing_sample",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "initial_pipedata",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "sequencing_centre",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "initial_pipeprocess",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "submission_date",
  { data_type => "date", default_value => undef, is_nullable => 1, size => 4 },
  "run_date",
  { data_type => "date", default_value => undef, is_nullable => 1, size => 4 },
  "data_received_date",
  { data_type => "date", default_value => undef, is_nullable => 1, size => 4 },
  "quality",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "sequencing_type",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "multiplexing_type",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("sequencingrun_id");
__PACKAGE__->add_unique_constraint("sequencingrun_identifier_key", ["identifier"]);
__PACKAGE__->add_unique_constraint("sequencingrun_id_pk", ["sequencingrun_id"]);
__PACKAGE__->belongs_to("quality", "SmallRNA::DB::Cvterm", { cvterm_id => "quality" });
__PACKAGE__->belongs_to(
  "initial_pipedata",
  "SmallRNA::DB::Pipedata",
  { pipedata_id => "initial_pipedata" },
);
__PACKAGE__->belongs_to(
  "sequencing_sample",
  "SmallRNA::DB::SequencingSample",
  { sequencing_sample_id => "sequencing_sample" },
);
__PACKAGE__->belongs_to(
  "multiplexing_type",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "multiplexing_type" },
);
__PACKAGE__->belongs_to(
  "sequencing_centre",
  "SmallRNA::DB::Organisation",
  { organisation_id => "sequencing_centre" },
);
__PACKAGE__->belongs_to(
  "sequencing_type",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "sequencing_type" },
);
__PACKAGE__->belongs_to(
  "initial_pipeprocess",
  "SmallRNA::DB::Pipeprocess",
  { pipeprocess_id => "initial_pipeprocess" },
);


# Created by DBIx::Class::Schema::Loader v0.04005
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8eHr3jUDiZ2WMT1b+5NqxA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
