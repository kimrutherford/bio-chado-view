package SmallRNA::DB::PipeprocessInPipedata;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("pipeprocess_in_pipedata");
__PACKAGE__->add_columns(
  "pipeprocess_in_pipedata_id",
  {
    data_type => "integer",
    default_value => "nextval('pipeprocess_in_pipedata_pipeprocess_in_pipedata_id_seq'::regclass)",
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
  "pipeprocess",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "pipedata",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
);
__PACKAGE__->set_primary_key("pipeprocess_in_pipedata_id");
__PACKAGE__->add_unique_constraint("pipeprocess_in_pk_constraint", ["pipeprocess", "pipedata"]);
__PACKAGE__->add_unique_constraint(
  "pipeprocess_in_pipedata_id_pk",
  ["pipeprocess_in_pipedata_id"],
);
__PACKAGE__->belongs_to(
  "pipeprocess",
  "SmallRNA::DB::Pipeprocess",
  { pipeprocess_id => "pipeprocess" },
);
__PACKAGE__->belongs_to(
  "pipedata",
  "SmallRNA::DB::Pipedata",
  { pipedata_id => "pipedata" },
);


# Created by DBIx::Class::Schema::Loader v0.04005
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XCtY0zkFIrnGOeB30SVukA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
