package ChadoView::DB::FeatureCvtermprop;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("feature_cvtermprop");
__PACKAGE__->add_columns(
  "feature_cvtermprop_id",
  {
    data_type => "integer",
    default_value => "nextval('feature_cvtermprop_feature_cvtermprop_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "feature_cvterm_id",
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
__PACKAGE__->set_primary_key("feature_cvtermprop_id");
__PACKAGE__->add_unique_constraint("feature_cvtermprop_pkey", ["feature_cvtermprop_id"]);
__PACKAGE__->add_unique_constraint(
  "feature_cvtermprop_c1",
  ["feature_cvterm_id", "type_id", "rank"],
);
__PACKAGE__->belongs_to(
  "feature_cvterm",
  "ChadoView::DB::FeatureCvterm",
  { feature_cvterm_id => "feature_cvterm_id" },
);
__PACKAGE__->belongs_to("type", "ChadoView::DB::Cvterm", { cvterm_id => "type_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XpjzdSsKh897bFf5oxutDg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
