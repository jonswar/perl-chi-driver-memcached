use inc::Module::Install;

name 'CHI-Driver-Memcached';
abstract 'Memcached driver for CHI';
all_from 'lib/CHI/Driver/Memcached.pm';
author 'Jonathan Swartz <swartz@pobox.com>';

perl_version '5.006';

build_requires 'Test::Class' => 0;
build_requires 'Test::More'  => 0;

requires 'CHI'    => '0.081';
requires 'Moose'  => '0.54';

license 'perl';

auto_install;

WriteAll;
