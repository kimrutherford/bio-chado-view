package SmallRNA::DB::Expression;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("expression");
__PACKAGE__->add_columns(
  "expression_id",
  {
    data_type => "integer",
    default_value => "nextval('expression_expression_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "description",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("expression_id");
__PACKAGE__->add_unique_constraint("expression_pkey", ["expression_id"]);
__PACKAGE__->has_many(
  "expression_cvterms",
  "SmallRNA::DB::ExpressionCvterm",
  { "foreign.expression_id" => "self.expression_id" },
);
__PACKAGE__->has_many(
  "expression_images",
  "SmallRNA::DB::ExpressionImage",
  { "foreign.expression_id" => "self.expression_id" },
);
__PACKAGE__->has_many(
  "expression_pubs",
  "SmallRNA::DB::ExpressionPub",
  { "foreign.expression_id" => "self.expression_id" },
);
__PACKAGE__->has_many(
  "feature_expressions",
  "SmallRNA::DB::FeatureExpression",
  { "foreign.expression_id" => "self.expression_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EzexMkeqK+HB7sjw+tMexg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
