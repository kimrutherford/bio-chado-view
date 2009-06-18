package SmallRNA::DB::PredictionEvidence;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("prediction_evidence");
__PACKAGE__->add_columns(
  "prediction_evidence_id",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "feature_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "evidence_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "analysis_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:03:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:SMVTe9OXf2kFtU7L9E5S+g


# You can replace this text with custom content, and it will be preserved on regeneration
1;
