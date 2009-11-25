package CHI::Driver::Memcached::Test::Driver::Fast;
use Moose;
use strict;
use warnings;

extends 'CHI::Driver::Memcached::Fast';
with 'CHI::Driver::Memcached::Test::Driver::Base';

__PACKAGE__->meta->make_immutable();

1;
