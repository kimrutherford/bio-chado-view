package SmallRNA::DB::SequencingSample;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("sequencing_sample");
__PACKAGE__->add_columns(
  "sequencing_sample_id",
  {
    data_type => "integer",
    default_value => "nextval('sequencing_sample_sequencing_sample_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "name",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("sequencing_sample_id");
__PACKAGE__->add_unique_constraint("sequencing_sample_name_key", ["name"]);
__PACKAGE__->add_unique_constraint("sequencing_sample_id_pk", ["sequencing_sample_id"]);
__PACKAGE__->has_many(
  "coded_samples",
  "SmallRNA::DB::CodedSample",
  { "foreign.sequencing_sample" => "self.sequencing_sample_id" },
);
__PACKAGE__->has_many(
  "sequencingruns",
  "SmallRNA::DB::Sequencingrun",
  { "foreign.sequencing_sample" => "self.sequencing_sample_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:arcDlxerpmABs5EDP0iX9g


# You can replace this text with custom content, and it will be preserved on regeneration
1;
