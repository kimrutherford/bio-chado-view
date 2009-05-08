package SmallRNA::Web::Controller::Edit;

=head1 NAME

SmallRNA::Web::Controller::Edit - controller to handler /edit/... requests

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Web::Controller::Edit

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

use base 'Catalyst::Controller::HTML::FormFu';

sub _get_field_values
{
  my $c = shift;
  my $table_name = shift;
  my $class_name = shift;
  my $field_name = shift;
  my $select_value = shift;

  my $rs = $c->schema()->resultset($class_name);

  my @res = ();

  my $table_id_column = $table_name . '_id';

  while (defined (my $row = $rs->next())) {
    my $option = { value => $row->$table_id_column(),
                   label => $row->$field_name };

    if (defined $select_value && $row->$table_id_column() eq $select_value) {
      $option->{attributes} = { selected => 't' };
    }

    push @res, $option;
  }

  return @res;
}

sub _initialise_form
{
  my $c = shift;
  my $type = shift;
  my $object = shift;
  my $form = shift;

  my @elements = ();

  my @field_infos = @{$c->config()->{class_info}->{$type}->{field_infos}};

  for my $field_info (@field_infos) {
    my $field_name = $field_info->{field_name};

    next unless $field_info->{editable};

    my $elem = {
      name => $field_name, label => $field_name
    };

    my $class_name = SmallRNA::DB::class_name_of_table($type);
    my $info_ref = $class_name->relationship_info($field_name);

    if (defined $info_ref) {
      my %info = %{$info_ref};
      my $referenced_class_name = $info{class};

      my $referenced_table = SmallRNA::DB::table_name_of_class($referenced_class_name);

      my $display_field = $c->config()->{class_info}->{$referenced_table}->{display_field};

      if (!defined $display_field) {
        die "no display_key_fields configuration for $referenced_table\n";
      }

      $elem->{type} = 'Select';
      my $table_id_column = $referenced_table . '_id';

      my $current_value = undef;
      if (defined $object->$field_name()) {
        $current_value = $object->$field_name()->$table_id_column();
      } 

      $elem->{options} = [_get_field_values($c, $referenced_table,
                                            $referenced_class_name, $display_field,
                                            $current_value)];

      my $db_source = $c->schema()->source($class_name);

      if ($db_source->column_info('treatment_type')->{is_nullable}) {
        # add a blank if this field can be null
        unshift @{$elem->{options}}, [0, ''];
      }
    } else {
      $elem->{type} = 'Text';
    }

    $elem->{value} = $object->$field_name();

    push @elements, $elem;
  }

  $form->auto_fieldset(1);
  $form->elements([
                    @elements,
                   { name => 'cancel', type => 'Submit', value => 'Cancel'},
                   { name => 'submit', type => 'Submit', value => 'Submit'},
                  ]);
}

sub object : Regex('edit/object/([^/]+)/([^/]+)') {
  my ($self, $c) = @_;

  my ($type, $object_id) = @{$c->req->captures()};

  my $object =
    $c->schema()->find_with_type(ucfirst $type, "${type}_id" => $object_id);

  my $st = $c->stash;

  $st->{title} = "Edit $type $object_id";
  $st->{template} = "edit.mhtml";

  my $form = $self->form;

  _initialise_form($c, $type, $object, $form);

  $form->process;

  $c->stash->{form} = $form;

  if ($form->submitted_and_valid()) {
    if ($c->req->param('cancel') eq 'Cancel') {
      $c->res->redirect($c->uri_for("/view/object/$type/$object_id"));
      $c->detach();
    }
    die $form->params()->{foo};
  }
}

1;
