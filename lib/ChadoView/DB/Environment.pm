package ChadoView::DB::Environment;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("environment");
__PACKAGE__->add_columns(
  "environment_id",
  {
    data_type => "integer",
    default_value => "nextval('environment_environment_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "uniquename",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "description",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("environment_id");
__PACKAGE__->add_unique_constraint("environment_pkey", ["environment_id"]);
__PACKAGE__->add_unique_constraint("environment_c1", ["uniquename"]);
__PACKAGE__->has_many(
  "environment_cvterms",
  "ChadoView::DB::EnvironmentCvterm",
  { "foreign.environment_id" => "self.environment_id" },
);
__PACKAGE__->has_many(
  "phendescs",
  "ChadoView::DB::Phendesc",
  { "foreign.environment_id" => "self.environment_id" },
);
__PACKAGE__->has_many(
  "phenotype_comparison_environment1_ids",
  "ChadoView::DB::PhenotypeComparison",
  { "foreign.environment1_id" => "self.environment_id" },
);
__PACKAGE__->has_many(
  "phenotype_comparison_environment2_ids",
  "ChadoView::DB::PhenotypeComparison",
  { "foreign.environment2_id" => "self.environment_id" },
);
__PACKAGE__->has_many(
  "phenstatements",
  "ChadoView::DB::Phenstatement",
  { "foreign.environment_id" => "self.environment_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yFTl1ZltYBUFW4dfSXZ97A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
