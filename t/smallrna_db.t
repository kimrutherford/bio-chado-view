use strict;
use warnings;
use Test::More tests => 6;

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::DB';
}

ok(SmallRNA::DB::class_name_of_table('person') eq 'SmallRNA::DB::Person');
ok(SmallRNA::DB::class_name_of_table('process_conf') eq 'SmallRNA::DB::ProcessConf');
ok(SmallRNA::DB::table_name_of_class('SmallRNA::DB::Person') eq 'person');
ok(SmallRNA::DB::table_name_of_class('SmallRNA::DB::ProcessConf') eq 'process_conf');

{
  package Test;
  sub test_id {
    return 42;
  }
  sub table {
    return "test";
  }
}

my $test_obj = {};

bless $test_obj, "Test";

ok(SmallRNA::DB::id_of_object($test_obj) == 42);

