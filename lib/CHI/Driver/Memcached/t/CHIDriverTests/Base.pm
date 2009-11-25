package CHI::Driver::Memcached::t::CHIDriverTests::Base;
use strict;
use warnings;
use CHI::Test;
use base qw(CHI::t::Driver);

__PACKAGE__->SKIP_CLASS("abstract base class");

my $testaddr = "127.0.0.1:11211";

sub required_modules {
    my $class = shift;
    return {
        $class->testing_driver_class => undef,
        'IO::Socket::INET'           => undef
    };
}

sub supports_get_namespaces { 0 }

sub connect_to_memcached : Test(startup) {
    my $self = shift;
    require IO::Socket::INET;
    my $msock = IO::Socket::INET->new(
        PeerAddr => $testaddr,
        Timeout  => 3
    );
    if ( !$msock ) {
        $self->SKIP_ALL("No memcached instance running at $testaddr");
    }
}

sub clear_memcached : Test(setup) {
    my ($self) = @_;

    my $cache = $self->new_cache();
    $cache->memd->flush_all();
}

sub new_cache_options {
    my $self = shift;

    # CHI::Driver::Memcached::Test::Driver defines get_keys for testing purposes
    return (
        $self->SUPER::new_cache_options(),
        driver       => undef,
        driver_class => $self->test_driver_class(),
        servers      => [$testaddr]
    );
}

sub set_standard_keys_and_values {
    my ($self) = @_;

    my ( $keys, $values ) = $self->SUPER::set_standard_keys_and_values();

    # memcached keys have max length of 250, plus we're adding namespace
    $keys->{'large'} = scalar( 'ab' x 100 );

    # memcached keys must not include control characters or whitespace
    $keys->{'space'} = 'space';
    $keys->{'mixed'} = 'mixed';

    return ( $keys, $values );
}

# TODO - Not working right now - fix later
sub test_size_awareness_with_subcaches { }

sub test_get_keys : Test(1) {
    my $self = shift;

    # Make sure we get a 'not supported' error with regular memcached driver
    my $cache = $self->SUPER::new_cache(
        driver_class => $self->testing_driver_class(),
        servers      => [$testaddr]
    );
    throws_ok(
        sub { $cache->get_keys() },
        qr/not supported/,
        "get_keys not supported"
    );
}

sub test_namespaces : Test(1) {
    my $self = shift;

    # Make sure we get a 'not supported' error with regular memcached driver
    my $cache = $self->SUPER::new_cache(
        driver_class => $self->testing_driver_class(),
        servers      => [$testaddr]
    );
    throws_ok(
        sub { $cache->get_namespaces() },
        qr/not supported/,
        "get_keys not supported"
    );
}

1;
