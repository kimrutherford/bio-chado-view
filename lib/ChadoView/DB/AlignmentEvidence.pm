package ChadoView::DB::AlignmentEvidence;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("alignment_evidence");
__PACKAGE__->add_columns(
  "alignment_evidence_id",
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


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rrfQn47fB2zZd+br5mUrYA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
