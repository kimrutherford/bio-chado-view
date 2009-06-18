package ChadoView::DB::Pubprop;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("pubprop");
__PACKAGE__->add_columns(
  "pubprop_id",
  {
    data_type => "integer",
    default_value => "nextval('pubprop_pubprop_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "pub_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "type_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "value",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "rank",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
);
__PACKAGE__->set_primary_key("pubprop_id");
__PACKAGE__->add_unique_constraint("pubprop_pub_id_key", ["pub_id", "type_id", "rank"]);
__PACKAGE__->add_unique_constraint("pubprop_pkey", ["pubprop_id"]);
__PACKAGE__->belongs_to("pub", "ChadoView::DB::Pub", { pub_id => "pub_id" });
__PACKAGE__->belongs_to("type", "ChadoView::DB::Cvterm", { cvterm_id => "type_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:iBxmhPrX+RfZz7Oi8Y879w


# You can replace this text with custom content, and it will be preserved on regeneration
1;
