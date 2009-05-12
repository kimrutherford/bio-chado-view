package SmallRNA::Web::Controller::View;

=head1 NAME

SmallRNA::Web::Controller::View - controller to handler /view/... requests

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Web::Controller::View

You can also look for information at:

=over 4

=back

=head1 COPYRIGHT & LICENSE

Copyright 2009 Kim Rutherford, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 FUNCTIONS

=cut

use strict;
use warnings;
use base 'Catalyst::Controller';

use Lingua::EN::Inflect::Number qw(to_PL);

=head2 object

 Function: Render details about an object (about a row in a table)
 Args    : $type - the object class from the URL
           $object_id - the id of an object to render

=cut
sub object : Local {
  my ($self, $c, $type, $object_id) = @_;

  my $st = $c->stash;

  eval {
    $st->{title} = "Details for $type with id: $object_id";
    $st->{template} = 'view/object/generic.mhtml';

    $st->{type} = $type;

    my $class_name = SmallRNA::DB::class_name_of_table($type);

    my $object =
      $c->schema()->find_with_type($class_name, "${type}_id" => $object_id);
    $st->{object} = $object;
  };
  if ($@) {
    $c->stash->{error} = qq(No object type "$type" and id = $object_id - $@);
    $c->forward('/start');
  }
}

=head2 list

 Function: Render a list of all objects of a given type
 Args    : $type - the object class from the URL

=cut
sub list : Local {
  my ($self, $c, $type) = @_;

  my $st = $c->stash;

  eval {
    $st->{title} = 'List of all ' . to_PL($type);
    $st->{template} = 'view/list_page.mhtml';
    $st->{type} = $type;

    my $class_name = SmallRNA::DB::class_name_of_table($type);

    $st->{rs} = $c->schema->resultset($class_name)->search(undef,
                                                             { order_by => $type . '_id' }
                                                           );

    $st->{page} = $c->req->param('page') || 1;
    $st->{numrows} = $c->req->param('numrows') || 20;
  };
  if ($@) {
    $c->stash->{error} = qq(No objects with type: $type - $@);
    $c->forward('/start');
  }

}

=head2 list_collection

 Function: Render a collection from an object of a given type
 Args    : $type - the object class from the URL
           $object_id - the id of an object
           $collection_name - the collection/relation to render

=cut
sub list_collection : LocalRegex('^list/(.+?)/(\d+?)/(.+?)$') {
  my ($self, $c) = @_;

  my ($type, $object_id, $collection_name) = @{$c->req->captures()};

  my $st = $c->stash;

  $st->{title} = "List view of $collection_name for $type with id $object_id";
  $st->{template} = 'view/collection.mhtml';
  $st->{type} = $type;
  my $class_name = SmallRNA::DB::class_name_of_table($type);
  my $object =
    $c->schema()->find_with_type($class_name, "${type}_id" => $object_id);

  $st->{object} = $object;
  $st->{collection_name} = $collection_name;
}

1;
