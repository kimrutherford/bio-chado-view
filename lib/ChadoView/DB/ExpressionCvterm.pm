package ChadoView::DB::ExpressionCvterm;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("expression_cvterm");
__PACKAGE__->add_columns(
  "expression_cvterm_id",
  {
    data_type => "integer",
    default_value => "nextval('expression_cvterm_expression_cvterm_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "expression_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "cvterm_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "rank",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "cvterm_type",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
);
__PACKAGE__->set_primary_key("expression_cvterm_id");
__PACKAGE__->add_unique_constraint("expression_cvterm_pkey", ["expression_cvterm_id"]);
__PACKAGE__->add_unique_constraint(
  "expression_cvterm_expression_id_key",
  ["expression_id", "cvterm_id"],
);
__PACKAGE__->belongs_to(
  "expression",
  "ChadoView::DB::Expression",
  { expression_id => "expression_id" },
);
__PACKAGE__->belongs_to(
  "cvterm",
  "ChadoView::DB::Cvterm",
  { cvterm_id => "cvterm_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:fxsCm0a+JUJVFIBQTesRAw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
