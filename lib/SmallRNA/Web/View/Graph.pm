package SmallRNA::Web::View::Graph;

=head1 NAME

SmallRNA::Web::View::Graph - Catalyst Graphics::Primitive View

=head1 SYNOPSIS

See L<SmallRNA::Web>

=head1 DESCRIPTION

Catalyst Graphics::Primitive View.

=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

use strict;
use base 'Catalyst::View::Graphics::Primitive';

use Chart::Clicker;
use Chart::Clicker::Context;
use Chart::Clicker::Data::DataSet;
use Chart::Clicker::Data::Marker;
use Chart::Clicker::Data::Series;
use Chart::Clicker::Renderer::Point;
use Geometry::Primitive::Rectangle;
use Graphics::Color::RGB;



1;
