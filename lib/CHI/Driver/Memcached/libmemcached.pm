package CHI::Driver::Memcached::libmemcached;

use Moo;
use strict;
use warnings;

extends 'CHI::Driver::Memcached::Base';

has '+memd_class' => ( default => 'Cache::Memcached::libmemcached' );

1;

__END__

=pod

=head1 NAME

CHI::Driver::Memcached::libmemcached -- Distributed cache via
Cache::Memcached::libmemcached

=head1 SYNOPSIS

    use CHI;

    my $cache = CHI->new(
        driver => 'Memcached::libmemcached',
        namespace => 'products',
        servers => [ "10.0.0.15:11211", "10.0.0.15:11212", "/var/sock/memcached",
        "10.0.0.17:11211", [ "10.0.0.17:11211", 3 ] ],
        debug => 0,
        compress_threshold => 10_000,
    );

=head1 DESCRIPTION

A CHI driver that uses
L<Cache::Memcached::libmemcached|Cache::Memcached::libmemcached> to store data
in the specified memcached server(s). From the perspective of the CHI API, the
feature set is nearly identical to
L<CHI::Driver::Memcached|CHI::Driver::Memcached>.

=head1 AUTHOR

Jonathan Swartz

=head1 SEE ALSO

L<CHI|CHI>, L<Cache::Memcached::libmemcached|Cache::Memcached::libmemcached>,
L<CHI::Driver::Memcached>, L<CHI::Driver::Memcached::Fast>

=head1 COPYRIGHT & LICENSE

Copyright (C) 2007 Jonathan Swartz.

CHI::Driver::Memcached is provided "as is" and without any express or implied
warranties, including, without limitation, the implied warranties of
merchantibility and fitness for a particular purpose.

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut
