package SmallRNA::DB::Libraryprop;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("libraryprop");
__PACKAGE__->add_columns(
  "libraryprop_id",
  {
    data_type => "integer",
    default_value => "nextval('libraryprop_libraryprop_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "library_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "type_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "value",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "rank",
  { data_type => "integer", default_value => 0, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("libraryprop_id");
__PACKAGE__->add_unique_constraint("libraryprop_c1", ["library_id", "type_id", "rank"]);
__PACKAGE__->add_unique_constraint("libraryprop_pkey", ["libraryprop_id"]);
__PACKAGE__->belongs_to(
  "library",
  "SmallRNA::DB::Library",
  { library_id => "library_id" },
);
__PACKAGE__->belongs_to("type", "SmallRNA::DB::Cvterm", { cvterm_id => "type_id" });
__PACKAGE__->has_many(
  "libraryprop_pubs",
  "SmallRNA::DB::LibrarypropPub",
  { "foreign.libraryprop_id" => "self.libraryprop_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RkrqFCutc/ptwiRlZkfn0g


# You can replace this text with custom content, and it will be preserved on regeneration
1;
