package ChadoView::DB::PhenotypeComparisonCvterm;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("phenotype_comparison_cvterm");
__PACKAGE__->add_columns(
  "phenotype_comparison_cvterm_id",
  {
    data_type => "integer",
    default_value => "nextval('phenotype_comparison_cvterm_phenotype_comparison_cvterm_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "phenotype_comparison_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "cvterm_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "rank",
  { data_type => "integer", default_value => 0, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("phenotype_comparison_cvterm_id");
__PACKAGE__->add_unique_constraint(
  "phenotype_comparison_cvterm_pkey",
  ["phenotype_comparison_cvterm_id"],
);
__PACKAGE__->add_unique_constraint(
  "phenotype_comparison_cvterm_c1",
  ["phenotype_comparison_id", "cvterm_id"],
);
__PACKAGE__->belongs_to(
  "phenotype_comparison",
  "ChadoView::DB::PhenotypeComparison",
  { "phenotype_comparison_id" => "phenotype_comparison_id" },
);
__PACKAGE__->belongs_to(
  "cvterm",
  "ChadoView::DB::Cvterm",
  { cvterm_id => "cvterm_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JEQ7JM/biDDqaONfNcIgbw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
