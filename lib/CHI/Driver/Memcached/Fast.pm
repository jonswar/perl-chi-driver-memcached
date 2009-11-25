package CHI::Driver::Memcached::Fast;
use Moose;
use strict;
use warnings;

extends 'CHI::Driver::Memcached::Base';
has '+memd_class' => ( default => 'Cache::Memcached::Fast' );

__PACKAGE__->meta->make_immutable();

1;
