use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'SmallRNA::Web' }
BEGIN { use_ok 'SmallRNA::Web::Controller::Root' }

ok( request('/')->is_success, 'Request should succeed' );
