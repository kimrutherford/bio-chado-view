package SmallRNA::DB::GffattsSlim;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("gffatts_slim");
__PACKAGE__->add_columns(
  "feature_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "type",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "attribute",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Y5BpXpbliUvM1IKEtLISGA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
