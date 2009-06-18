package ChadoView::Web;

use strict;
use warnings;

use Catalyst::Runtime '5.70';

use Sys::Hostname;

use parent qw/Catalyst/;
use Catalyst qw/ConfigLoader
                CommandLine
                StackTrace
                Authentication
                Session
                Session::Store::FastMmap
                Session::State::Cookie
                Static::Simple/;
our $VERSION = '0.01';

my $login = getlogin() || $ENV{USER};
my ($host) = Sys::Hostname::hostname() =~ m/^([^\.]+)/;

if (!defined $login) {
  # probably running in apache
  $login = 'apache';
}

__PACKAGE__->config(name => 'ChadoView::Web',
                    'Plugin::ConfigLoader' => {
                      file                => __PACKAGE__->path_to('chadoview_web'),
                      config_local_suffix => $login . '_' . $host,
                    },
                    'View::Graphics::Primitive' => {
                      driver => 'Cairo',
                      driver_args => { format => 'pdf' },
                      content_type => 'application/pdf'
                    }
                   );

# Start the application
__PACKAGE__->setup();

my $config = __PACKAGE__->config();
  
$config->{data_directory} = 
  $config->{pipeline_directory} . '/' .
  $config->{data_sub_directory};

# this is hacky, but allow us to call methods on the config object
bless $config, 'ChadoView::Config';

use ChadoView::Config;

$config->setup();

# shortcut to the schema
sub schema
{
  my $self = shift;
  return $self->model('ChadoViewModel')->schema();
}


=head1 NAME

ChadoView::Web - Chado View application

=head1 SYNOPSIS

    script/chadoview_web_server.pl

=head1 SEE ALSO

L<ChadoView::Web::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Kim Rutherford <kmr44@cam.ac.uk>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
