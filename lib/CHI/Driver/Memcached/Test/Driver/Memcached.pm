package CHI::Driver::Memcached::Test::Driver::Memcached;
use Moose;
use strict;
use warnings;

extends 'CHI::Driver::Memcached';
with 'CHI::Driver::Memcached::Test::Driver::Base';

__PACKAGE__->meta->make_immutable();

1;
