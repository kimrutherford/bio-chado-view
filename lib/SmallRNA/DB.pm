package SmallRNA::DB;

use strict;
use warnings;

use base 'DBIx::Class::Schema';

__PACKAGE__->load_classes;


# Created by DBIx::Class::Schema::Loader v0.04005
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:c8bmoIPFDvtC/D52J11brg

for my $source (__PACKAGE__->sources()) {
  __PACKAGE__->source($source)->resultset_class('SmallRNA::DBResultSet');
}

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::DB

You can also look for information at:

=over 4

=back

=head1 COPYRIGHT & LICENSE

Copyright 2009 Kim Rutherford, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 FUNCTIONS

=cut

use Params::Validate qw(:all);
use Carp;

=head2 schema

 Usage   : my $schema = SmallRNA::DB->schema($c->config());
 Function: Return a new database connection (schema)
 Args    : $config - if null use the config file from the current directory
                     or some other default location (eg. /etc/smallrna.yaml)

=cut
sub schema
{
  my $self = shift;
  my $smallrna_config = shift;

  if (!defined $smallrna_config) {
    croak "schema() needs a config hash as argument\n";
  }

  my $config = $smallrna_config->{'Model::SmallRNAModel'}{connect_info};

  return $self->connect($config->[0], $config->[1], $config->[2],
                        {
                         RaiseError => 1,
                         AutoCommit => 1
                        })
}

=head2 find_with_type

 Usage   : my $obj = $schema->find_with_type('Organism', 'abbreviation', 'SCHPO');
 Function: Return the object of the given type that has the given key field with
           given value
 Args    : $type - an unqualified class name like 'Person'
           $field_name - the field name to use when searching
           $value - the value to search for

=cut
sub find_with_type
{
  my $self = shift;
  my ($type, $field_name, $value) = validate_pos(@_, 1, 1, 1);

  $type = ucfirst $type;

  my $rs = $self->resultset($type);
  my $obj = $rs->find({ $field_name => $value });
  if (defined $obj) {
    return $obj;
  } else {
    croak "error: could not find a '$type' with $field_name = '$value'\n";
  }
}

=head2 create_with_type

 Usage   : my $field_data = { first_name => 'Charles', last_name => 'Darwin',
                              organisation => $organisation };
           my $obj = $schema->create_with_type('Person', $field_data);
 Function: Create an object of the given type, initialising with the $field_data
 Args    : $type - an unqualified class name like 'Person'
           $field_data - a hashref containing all the fields to initialise in
           the new object
 Returns : a reference to the new object

=cut
sub create_with_type
{
  my $self = shift;
  my ($type, $field_data) = validate_pos(@_, 1, 1);

  my $rs = $self->resultset($type);

  my $obj = undef;

  eval {
    $obj = $rs->create($field_data);
  };
  if ($@) {
    my $data_string = '{' . (join ', ', map {
      "'$_'" . ' => ' . "'" . $field_data->{$_} . "'"
    } keys %$field_data) . '}';
    croak "error while creating $type: $@ with args: $data_string\n";
  }

  if (defined $obj) {
    return $obj;
  } else {
    croak "error: could not create a '$type'\n";
  }
}

=head2 class_name_of_table

 Usage   : my $class_name = SmallRNA::DB::class_name_of_table($table_name);
 Function: Return the class name of a given table name
 Args    : $table_name - the table name
 Returns : the qualified class name, eg. SmallRNA::DB::Person

=cut
sub class_name_of_table
{
  my $class_name = shift;
  $class_name =~ s/_(\w)/uc $1/eg;
  return 'SmallRNA::DB::' . ucfirst $class_name;
}

=head2 table_name_of_class

 Usage   : my $table_name = SmallRNA::DB::table_name_of_class($class_name);
 Function: Return the table name of a given class name
 Args    : $class_name - the class name, can be unqualified or qualified
 Returns : the table name

=cut
sub table_name_of_class
{
  my $class_name = shift;
  $class_name =~ s/(?:.*::)//;
  $class_name = join '_', map { lc } ($class_name =~ m/([A-Z][a-z]+)/g);
  return $class_name;
}

=head2 class_name_of_relationship

 Usage   : my $name = SmallRNA::DB::class_name_of_relationship($object, $relname);
 Function: Return the class name of the object referred to by a relationship
 Args    : $object - an object
           $relname - the relationship name
 Returns : the class name

=cut
sub class_name_of_relationship
{
  my $object = shift;
  my $relname = shift;

  my %info = %{$object->relationship_info($relname)};
  return $info{class};
}

1;
