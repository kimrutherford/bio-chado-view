# IMPORTANT: if you delete this file your app will not work as
# expected.  you have been warned
use inc::Module::Install;

name 'ChadoView-Web';
all_from 'lib/ChadoView/Web.pm';

requires 'Catalyst::Runtime' => '5.70000';
requires 'Catalyst::Plugin::Authentication';
requires 'Catalyst::Plugin::CommandLine';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Plugin::Session::Store::FastMmap';
requires 'Catalyst::Plugin::StackTrace';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Controller::HTML::FormFu';
requires 'Catalyst::Model::DBIC::Schema';
requires 'Catalyst::View::Graphics::Primitive';
requires 'Catalyst::View::Mason';
requires 'Chart::Clicker';
requires 'DBIx::Class::ResultSet::Data::Pageset';
requires 'Params::Validate';
requires 'YAML';
requires 'DBIx::Class';
requires 'Text::CSV';
requires 'IO::All';
requires 'DBIx::Class';
requires 'DBIx::Class::Schema';
requires 'DBD::Pg';
requires 'DateTime';
requires 'Params::Validate';
requires 'File::Copy::Recursive';

requires 'parent';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
