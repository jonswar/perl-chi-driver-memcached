#!perl -w
use strict;
use warnings;
use lib 't/lib';
use CHI::Driver::Memcached::t::Sanity;
CHI::Driver::Memcached::t::Sanity->runtests;
