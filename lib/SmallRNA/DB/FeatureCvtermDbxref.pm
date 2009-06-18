package SmallRNA::DB::FeatureCvtermDbxref;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("feature_cvterm_dbxref");
__PACKAGE__->add_columns(
  "feature_cvterm_dbxref_id",
  {
    data_type => "integer",
    default_value => "nextval('feature_cvterm_dbxref_feature_cvterm_dbxref_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "feature_cvterm_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "dbxref_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("feature_cvterm_dbxref_id");
__PACKAGE__->add_unique_constraint("feature_cvterm_dbxref_pkey", ["feature_cvterm_dbxref_id"]);
__PACKAGE__->add_unique_constraint(
  "feature_cvterm_dbxref_c1",
  ["feature_cvterm_id", "dbxref_id"],
);
__PACKAGE__->belongs_to(
  "feature_cvterm",
  "SmallRNA::DB::FeatureCvterm",
  { feature_cvterm_id => "feature_cvterm_id" },
);
__PACKAGE__->belongs_to("dbxref", "SmallRNA::DB::Dbxref", { dbxref_id => "dbxref_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Sm684y5Qf61TIsOd/iAhNA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
