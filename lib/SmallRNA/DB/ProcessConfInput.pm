package SmallRNA::DB::ProcessConfInput;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("process_conf_input");
__PACKAGE__->add_columns(
  "process_conf_input_id",
  {
    data_type => "integer",
    default_value => "nextval('process_conf_input_process_conf_input_id_seq'::regclass)",
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
  "process_conf",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "format_type",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "content_type",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "ecotype",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
);
__PACKAGE__->set_primary_key("process_conf_input_id");
__PACKAGE__->add_unique_constraint("process_conf_input_id_pk", ["process_conf_input_id"]);
__PACKAGE__->belongs_to(
  "format_type",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "format_type" },
);
__PACKAGE__->belongs_to(
  "process_conf",
  "SmallRNA::DB::ProcessConf",
  { process_conf_id => "process_conf" },
);
__PACKAGE__->belongs_to(
  "content_type",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "content_type" },
);
__PACKAGE__->belongs_to(
  "ecotype",
  "SmallRNA::DB::Ecotype",
  { ecotype_id => "ecotype" },
);


# Created by DBIx::Class::Schema::Loader v0.04005
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xEljkkzHZsPmjxHOpW5sKg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
