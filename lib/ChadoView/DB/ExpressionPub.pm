package ChadoView::DB::ExpressionPub;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("expression_pub");
__PACKAGE__->add_columns(
  "expression_pub_id",
  {
    data_type => "integer",
    default_value => "nextval('expression_pub_expression_pub_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "expression_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "pub_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("expression_pub_id");
__PACKAGE__->add_unique_constraint("expression_pub_pkey", ["expression_pub_id"]);
__PACKAGE__->add_unique_constraint(
  "expression_pub_expression_id_key",
  ["expression_id", "pub_id"],
);
__PACKAGE__->belongs_to(
  "expression",
  "ChadoView::DB::Expression",
  { expression_id => "expression_id" },
);
__PACKAGE__->belongs_to("pub", "ChadoView::DB::Pub", { pub_id => "pub_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:UwBCW2Pz0RnpETnIS3Yytg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
