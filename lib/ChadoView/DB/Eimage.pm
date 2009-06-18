package ChadoView::DB::Eimage;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("eimage");
__PACKAGE__->add_columns(
  "eimage_id",
  {
    data_type => "integer",
    default_value => "nextval('eimage_eimage_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "eimage_data",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "eimage_type",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 255,
  },
  "image_uri",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
);
__PACKAGE__->set_primary_key("eimage_id");
__PACKAGE__->add_unique_constraint("eimage_pkey", ["eimage_id"]);
__PACKAGE__->has_many(
  "expression_images",
  "ChadoView::DB::ExpressionImage",
  { "foreign.eimage_id" => "self.eimage_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YCyJMeRUC7ozlC5O4o4lzQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
