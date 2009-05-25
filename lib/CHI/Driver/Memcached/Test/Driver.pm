package CHI::Driver::Memcached::Test::Driver;
use strict;
use warnings;
use Moose;
use CHI::Util qw(dps);
use base qw(CHI::Driver::Memcached);

__PACKAGE__->meta->make_immutable;

# Memcached doesn't support get_keys. For testing purposes, define get_keys
# and clear by checking for all keys used during testing.
#

# Reverse declare_unsupported_methods
#
foreach my $method (qw(dump_as_hash is_empty purge)) {
    no strict 'refs';
    *{ __PACKAGE__ . "::$method" } = sub {
        my $self        = shift;
        my $full_method = "CHI::Driver::$method";
        return $self->$full_method(@_);
    };
}

my @all_test_keys = (
    'space',    'a',
    0,          1,
    'medium',   'medium2',
    'mixed',    scalar( 'ab' x 100 ),
    'arrayref', 'hashref',
    ( map { "done$_" } ( 0 .. 2 ) ), ( map { "key$_" } ( 0 .. 20 ) )
);

sub get_keys {
    my $self = shift;

    my $values = $self->get_multi_hashref( \@all_test_keys );
    my @defined_keys = grep { defined $values->{$_} } keys(%$values);
    return @defined_keys;
}

sub clear {
    my $self = shift;

    foreach my $key (@all_test_keys) {
        $self->remove($key);
    }
}

1;
