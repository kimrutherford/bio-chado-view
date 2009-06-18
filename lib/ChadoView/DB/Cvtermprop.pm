package ChadoView::DB::Cvtermprop;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("cvtermprop");
__PACKAGE__->add_columns(
  "cvtermprop_id",
  {
    data_type => "integer",
    default_value => "nextval('cvtermprop_cvtermprop_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "cvterm_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "type_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "value",
  {
    data_type => "text",
    default_value => "''::text",
    is_nullable => 0,
    size => undef,
  },
  "rank",
  { data_type => "integer", default_value => 0, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("cvtermprop_id");
__PACKAGE__->add_unique_constraint("cvtermprop_pkey", ["cvtermprop_id"]);
__PACKAGE__->add_unique_constraint(
  "cvtermprop_cvterm_id_key",
  ["cvterm_id", "type_id", "value", "rank"],
);
__PACKAGE__->belongs_to(
  "cvterm",
  "ChadoView::DB::Cvterm",
  { cvterm_id => "cvterm_id" },
);
__PACKAGE__->belongs_to("type", "ChadoView::DB::Cvterm", { cvterm_id => "type_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:B7ncjUozvzXxHMKFcgaFig


# You can replace this text with custom content, and it will be preserved on regeneration
1;
