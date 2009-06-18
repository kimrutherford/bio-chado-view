package SmallRNA::DB::FeatureDbxref;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("feature_dbxref");
__PACKAGE__->add_columns(
  "feature_dbxref_id",
  {
    data_type => "integer",
    default_value => "nextval('feature_dbxref_feature_dbxref_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "feature_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "dbxref_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "is_current",
  {
    data_type => "boolean",
    default_value => "true",
    is_nullable => 0,
    size => 1,
  },
);
__PACKAGE__->set_primary_key("feature_dbxref_id");
__PACKAGE__->add_unique_constraint("feature_dbxref_pkey", ["feature_dbxref_id"]);
__PACKAGE__->add_unique_constraint("feature_dbxref_feature_id_key", ["feature_id", "dbxref_id"]);
__PACKAGE__->belongs_to(
  "feature",
  "SmallRNA::DB::Feature",
  { feature_id => "feature_id" },
);
__PACKAGE__->belongs_to("dbxref", "SmallRNA::DB::Dbxref", { dbxref_id => "dbxref_id" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Ulw0a29yEe69rE1ZlZyhNw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
