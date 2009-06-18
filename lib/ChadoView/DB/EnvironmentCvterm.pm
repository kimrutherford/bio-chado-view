package ChadoView::DB::EnvironmentCvterm;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("environment_cvterm");
__PACKAGE__->add_columns(
  "environment_cvterm_id",
  {
    data_type => "integer",
    default_value => "nextval('environment_cvterm_environment_cvterm_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "environment_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "cvterm_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("environment_cvterm_id");
__PACKAGE__->add_unique_constraint("environment_cvterm_pkey", ["environment_cvterm_id"]);
__PACKAGE__->add_unique_constraint("environment_cvterm_c1", ["environment_id", "cvterm_id"]);
__PACKAGE__->belongs_to(
  "environment",
  "ChadoView::DB::Environment",
  { environment_id => "environment_id" },
);
__PACKAGE__->belongs_to(
  "cvterm",
  "ChadoView::DB::Cvterm",
  { cvterm_id => "cvterm_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+PkxfMKHnheLH5/YDWnpVA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
