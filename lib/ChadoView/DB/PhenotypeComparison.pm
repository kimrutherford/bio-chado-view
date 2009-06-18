package ChadoView::DB::PhenotypeComparison;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("phenotype_comparison");
__PACKAGE__->add_columns(
  "phenotype_comparison_id",
  {
    data_type => "integer",
    default_value => "nextval('phenotype_comparison_phenotype_comparison_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "genotype1_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "environment1_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "genotype2_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "environment2_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "phenotype1_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "phenotype2_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "pub_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "organism_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("phenotype_comparison_id");
__PACKAGE__->add_unique_constraint("phenotype_comparison_pkey", ["phenotype_comparison_id"]);
__PACKAGE__->add_unique_constraint(
  "phenotype_comparison_c1",
  [
    "genotype1_id",
    "environment1_id",
    "genotype2_id",
    "environment2_id",
    "phenotype1_id",
    "pub_id",
  ],
);
__PACKAGE__->belongs_to(
  "organism",
  "ChadoView::DB::Organism",
  { organism_id => "organism_id" },
);
__PACKAGE__->belongs_to(
  "genotype1",
  "ChadoView::DB::Genotype",
  { genotype_id => "genotype1_id" },
);
__PACKAGE__->belongs_to("pub", "ChadoView::DB::Pub", { pub_id => "pub_id" });
__PACKAGE__->belongs_to(
  "phenotype1",
  "ChadoView::DB::Phenotype",
  { phenotype_id => "phenotype1_id" },
);
__PACKAGE__->belongs_to(
  "environment1",
  "ChadoView::DB::Environment",
  { environment_id => "environment1_id" },
);
__PACKAGE__->belongs_to(
  "environment2",
  "ChadoView::DB::Environment",
  { environment_id => "environment2_id" },
);
__PACKAGE__->belongs_to(
  "genotype2",
  "ChadoView::DB::Genotype",
  { genotype_id => "genotype2_id" },
);
__PACKAGE__->belongs_to(
  "phenotype2",
  "ChadoView::DB::Phenotype",
  { phenotype_id => "phenotype2_id" },
);
__PACKAGE__->has_many(
  "phenotype_comparison_cvterms",
  "ChadoView::DB::PhenotypeComparisonCvterm",
  {
    "foreign.phenotype_comparison_id" => "self.phenotype_comparison_id",
  },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cajMtXWKS5cLwFXWIws3Fg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
