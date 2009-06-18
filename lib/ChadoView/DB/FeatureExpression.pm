package ChadoView::DB::FeatureExpression;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("feature_expression");
__PACKAGE__->add_columns(
  "feature_expression_id",
  {
    data_type => "integer",
    default_value => "nextval('feature_expression_feature_expression_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "expression_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "feature_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("feature_expression_id");
__PACKAGE__->add_unique_constraint("feature_expression_pkey", ["feature_expression_id"]);
__PACKAGE__->add_unique_constraint(
  "feature_expression_expression_id_key",
  ["expression_id", "feature_id"],
);
__PACKAGE__->belongs_to(
  "expression",
  "ChadoView::DB::Expression",
  { expression_id => "expression_id" },
);
__PACKAGE__->belongs_to(
  "feature",
  "ChadoView::DB::Feature",
  { feature_id => "feature_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0CG5bNfms9rK3cJXt30nXQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
