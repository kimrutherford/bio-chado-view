package ChadoView::DB::Analysisfeature;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("analysisfeature");
__PACKAGE__->add_columns(
  "analysisfeature_id",
  {
    data_type => "integer",
    default_value => "nextval('analysisfeature_analysisfeature_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "feature_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "analysis_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "rawscore",
  {
    data_type => "double precision",
    default_value => undef,
    is_nullable => 1,
    size => 8,
  },
  "normscore",
  {
    data_type => "double precision",
    default_value => undef,
    is_nullable => 1,
    size => 8,
  },
  "significance",
  {
    data_type => "double precision",
    default_value => undef,
    is_nullable => 1,
    size => 8,
  },
  "identity",
  {
    data_type => "double precision",
    default_value => undef,
    is_nullable => 1,
    size => 8,
  },
);
__PACKAGE__->set_primary_key("analysisfeature_id");
__PACKAGE__->add_unique_constraint(
  "analysisfeature_feature_id_key",
  ["feature_id", "analysis_id"],
);
__PACKAGE__->add_unique_constraint("analysisfeature_pkey", ["analysisfeature_id"]);
__PACKAGE__->belongs_to(
  "feature",
  "ChadoView::DB::Feature",
  { feature_id => "feature_id" },
);
__PACKAGE__->belongs_to(
  "analysis",
  "ChadoView::DB::Analysis",
  { analysis_id => "analysis_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:feXT3EnfdV5G8/hZ1KtyAg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
