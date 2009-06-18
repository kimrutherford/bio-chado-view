package SmallRNA::DB::Featurerange;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("featurerange");
__PACKAGE__->add_columns(
  "featurerange_id",
  {
    data_type => "integer",
    default_value => "nextval('featurerange_featurerange_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "featuremap_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "feature_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "leftstartf_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "leftendf_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "rightstartf_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "rightendf_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "rangestr",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
);
__PACKAGE__->set_primary_key("featurerange_id");
__PACKAGE__->add_unique_constraint("featurerange_pkey", ["featurerange_id"]);
__PACKAGE__->belongs_to(
  "leftstartf",
  "SmallRNA::DB::Feature",
  { feature_id => "leftstartf_id" },
);
__PACKAGE__->belongs_to(
  "featuremap",
  "SmallRNA::DB::Featuremap",
  { featuremap_id => "featuremap_id" },
);
__PACKAGE__->belongs_to(
  "rightendf",
  "SmallRNA::DB::Feature",
  { feature_id => "rightendf_id" },
);
__PACKAGE__->belongs_to(
  "rightstartf",
  "SmallRNA::DB::Feature",
  { feature_id => "rightstartf_id" },
);
__PACKAGE__->belongs_to(
  "feature",
  "SmallRNA::DB::Feature",
  { feature_id => "feature_id" },
);
__PACKAGE__->belongs_to(
  "leftendf",
  "SmallRNA::DB::Feature",
  { feature_id => "leftendf_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:QZrGha/2t2dSXJeTVZV5xQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
