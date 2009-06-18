package SmallRNA::DB::FeaturelocAllcoords;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("featureloc_allcoords");
__PACKAGE__->add_columns(
  "featureloc_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "feature_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "srcfeature_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "fmin",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "is_fmin_partial",
  { data_type => "boolean", default_value => undef, is_nullable => 1, size => 1 },
  "fmax",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "is_fmax_partial",
  { data_type => "boolean", default_value => undef, is_nullable => 1, size => 1 },
  "strand",
  {
    data_type => "smallint",
    default_value => undef,
    is_nullable => 1,
    size => 2,
  },
  "phase",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "residue_info",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "locgroup",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "rank",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "gbeg",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "gend",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "nbeg",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "nend",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ulGM0xn0MoIIU58QSw93/w


# You can replace this text with custom content, and it will be preserved on regeneration
1;
