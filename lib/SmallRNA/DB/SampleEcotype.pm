package SmallRNA::DB::SampleEcotype;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("sample_ecotype");
__PACKAGE__->add_columns(
  "sample_ecotype_id",
  {
    data_type => "integer",
    default_value => "nextval('sample_ecotype_sample_ecotype_id_seq'::regclass)",
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
  "ecotype",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("sample_ecotype_id");
__PACKAGE__->add_unique_constraint("sample_ecotype_id_pk", ["sample_ecotype_id"]);
__PACKAGE__->belongs_to(
  "ecotype",
  "SmallRNA::DB::Ecotype",
  { ecotype_id => "ecotype" },
);
__PACKAGE__->belongs_to("sample", "SmallRNA::DB::Sample", { sample_id => "sample" });


# Created by DBIx::Class::Schema::Loader v0.04005
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3kvx8VG06E1Mu215Pkl/NQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
