package ChadoView::DB::Cv;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("cv");
__PACKAGE__->add_columns(
  "cv_id",
  {
    data_type => "integer",
    default_value => "nextval('cv_cv_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "name",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 255,
  },
  "definition",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("cv_id");
__PACKAGE__->add_unique_constraint("cv_name_key", ["name"]);
__PACKAGE__->add_unique_constraint("cv_pkey", ["cv_id"]);
__PACKAGE__->has_many(
  "cvterms",
  "ChadoView::DB::Cvterm",
  { "foreign.cv_id" => "self.cv_id" },
);
__PACKAGE__->has_many(
  "cvtermpaths",
  "ChadoView::DB::Cvtermpath",
  { "foreign.cv_id" => "self.cv_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ZeGaNZh005w+0gnkgbTulg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
