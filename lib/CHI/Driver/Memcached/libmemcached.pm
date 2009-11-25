package CHI::Driver::Memcached::libmemcached;
use Moose;
use strict;
use warnings;

extends 'CHI::Driver::Memcached::Base';
has '+memd_class' => ( default => 'Cache::Memcached::libmemcached' );

__PACKAGE__->meta->make_immutable();

1;
