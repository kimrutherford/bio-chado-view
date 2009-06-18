# IMPORTANT: if you delete this file your app will not work as
# expected.  you have been warned
use inc::Module::Install;

name 'SmallRNA-Web';
all_from 'lib/SmallRNA/Web.pm';

requires 'Catalyst::Runtime' => '5.70000';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Params::Validate';
requires 'YAML';
requires 'DBIx::Class';
requires 'Text::CSV';
requires 'IO::All';
requires 'YAML';
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
