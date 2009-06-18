package ChadoView::DB::Genotype;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("genotype");
__PACKAGE__->add_columns(
  "genotype_id",
  {
    data_type => "integer",
    default_value => "nextval('genotype_genotype_id_seq'::regclass)",
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
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "name",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("genotype_id");
__PACKAGE__->add_unique_constraint("genotype_pkey", ["genotype_id"]);
__PACKAGE__->add_unique_constraint("genotype_c1", ["uniquename"]);
__PACKAGE__->has_many(
  "feature_genotypes",
  "ChadoView::DB::FeatureGenotype",
  { "foreign.genotype_id" => "self.genotype_id" },
);
__PACKAGE__->has_many(
  "phendescs",
  "ChadoView::DB::Phendesc",
  { "foreign.genotype_id" => "self.genotype_id" },
);
__PACKAGE__->has_many(
  "phenotype_comparison_genotype1_ids",
  "ChadoView::DB::PhenotypeComparison",
  { "foreign.genotype1_id" => "self.genotype_id" },
);
__PACKAGE__->has_many(
  "phenotype_comparison_genotype2_ids",
  "ChadoView::DB::PhenotypeComparison",
  { "foreign.genotype2_id" => "self.genotype_id" },
);
__PACKAGE__->has_many(
  "phenstatements",
  "ChadoView::DB::Phenstatement",
  { "foreign.genotype_id" => "self.genotype_id" },
);
__PACKAGE__->has_many(
  "stock_genotypes",
  "ChadoView::DB::StockGenotype",
  { "foreign.genotype_id" => "self.genotype_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-06-18 14:28:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rQBesEiq5wWed8IPDcsZMA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
