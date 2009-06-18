package SmallRNA::DB::FeaturelocPub;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("featureloc_pub");
__PACKAGE__->add_columns(
  "featureloc_pub_id",
  {
    data_type => "integer",
    default_value => "nextval('featureloc_pub_featureloc_pub_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "featureloc_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "pub_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("featureloc_pub_id");
__PACKAGE__->add_unique_constraint("featureloc_pub_c1", ["featureloc_id", "pub_id"]);
__PACKAGE__->add_unique_constraint("featureloc_pub_pkey", ["featureloc_pub_id"]);
__PACKAGE__->belongs_to(
  "featureloc",
  "SmallRNA::DB::Featureloc",
  { featureloc_id => "featureloc_id" },
);
__PACKAGE__->belongs_to("pub", "SmallRNA::DB::Pub", { pub_id => "pub_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:lTNFSKyiBIxJUQ4pE9COwQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
