package ChadoView::DB::Analysis;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("analysis");
__PACKAGE__->add_columns(
  "analysis_id",
  {
    data_type => "integer",
    default_value => "nextval('analysis_analysis_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "name",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "description",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "program",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 255,
  },
  "programversion",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 255,
  },
  "algorithm",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "sourcename",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "sourceversion",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "sourceuri",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "timeexecuted",
  {
    data_type => "timestamp without time zone",
    default_value => "('now'::text)::timestamp(6) with time zone",
    is_nullable => 0,
    size => 8,
  },
);
__PACKAGE__->set_primary_key("analysis_id");
__PACKAGE__->add_unique_constraint("analysis_pkey", ["analysis_id"]);
__PACKAGE__->add_unique_constraint(
  "analysis_program_key",
  ["program", "programversion", "sourcename"],
);
__PACKAGE__->has_many(
  "analysisfeatures",
  "ChadoView::DB::Analysisfeature",
  { "foreign.analysis_id" => "self.analysis_id" },
);
__PACKAGE__->has_many(
  "analysisprops",
  "ChadoView::DB::Analysisprop",
  { "foreign.analysis_id" => "self.analysis_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xhaxt9KuN7nUTOxoyXE2mA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
