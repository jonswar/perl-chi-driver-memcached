package CHI::Driver::Memcached::t::Sanity;
use strict;
use warnings;
use CHI::Driver::Memcached::Test;
use base qw(CHI::Driver::Memcached::Test::Class);

sub test_ok : Test(1) {
    ok( 1, '1 is ok' );
}

1;
