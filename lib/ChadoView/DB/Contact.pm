package ChadoView::DB::Contact;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("contact");
__PACKAGE__->add_columns(
  "contact_id",
  {
    data_type => "integer",
    default_value => "nextval('contact_contact_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "description",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "name",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 30,
  },
);
__PACKAGE__->set_primary_key("contact_id");
__PACKAGE__->add_unique_constraint("contact_pkey", ["contact_id"]);
__PACKAGE__->has_many(
  "dbs",
  "ChadoView::DB::Db",
  { "foreign.contact_id" => "self.contact_id" },
);
__PACKAGE__->has_many(
  "stockcollections",
  "ChadoView::DB::Stockcollection",
  { "foreign.contact_id" => "self.contact_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:4cKdCAtnPrJR/YYfacpwRA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
