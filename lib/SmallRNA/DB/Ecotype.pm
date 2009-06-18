package SmallRNA::DB::Ecotype;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("ecotype");
__PACKAGE__->add_columns(
  "ecotype_id",
  {
    data_type => "integer",
    default_value => "nextval('ecotype_ecotype_id_seq'::regclass)",
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
  "organism",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "description",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("ecotype_id");
__PACKAGE__->add_unique_constraint("ecotype_id_pk", ["ecotype_id"]);
__PACKAGE__->belongs_to(
  "organism",
  "SmallRNA::DB::Organism",
  { organism_id => "organism" },
);
__PACKAGE__->has_many(
  "process_conf_inputs",
  "SmallRNA::DB::ProcessConfInput",
  { "foreign.ecotype" => "self.ecotype_id" },
);
__PACKAGE__->has_many(
  "sample_ecotypes",
  "SmallRNA::DB::SampleEcotype",
  { "foreign.ecotype" => "self.ecotype_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:e6Qau0DRTw923KppwJ/JYA

# the description and the organism full name, used when displaying ecotypes
sub long_description
{
  my $self = shift;

  return $self->description() . ' ' . $self->organism()->full_name();
}


# You can replace this text with custom content, and it will be preserved on regeneration
1;
