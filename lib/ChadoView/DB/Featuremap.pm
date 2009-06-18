package ChadoView::DB::Featuremap;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("featuremap");
__PACKAGE__->add_columns(
  "featuremap_id",
  {
    data_type => "integer",
    default_value => "nextval('featuremap_featuremap_id_seq'::regclass)",
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
  "unittype_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
);
__PACKAGE__->set_primary_key("featuremap_id");
__PACKAGE__->add_unique_constraint("featuremap_c1", ["name"]);
__PACKAGE__->add_unique_constraint("featuremap_pkey", ["featuremap_id"]);
__PACKAGE__->belongs_to(
  "unittype",
  "ChadoView::DB::Cvterm",
  { cvterm_id => "unittype_id" },
);
__PACKAGE__->has_many(
  "featuremap_pubs",
  "ChadoView::DB::FeaturemapPub",
  { "foreign.featuremap_id" => "self.featuremap_id" },
);
__PACKAGE__->has_many(
  "featurepo",
  "ChadoView::DB::Featurepos",
  { "foreign.featuremap_id" => "self.featuremap_id" },
);
__PACKAGE__->has_many(
  "featureranges",
  "ChadoView::DB::Featurerange",
  { "foreign.featuremap_id" => "self.featuremap_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:H1KJRBaoN/JOkIYUGWHmfQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
