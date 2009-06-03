package CHI::Driver::Memcached::Test::Driver;
use strict;
use warnings;
use Moose;
use CHI::t::Driver;
use base qw(CHI::Driver::Memcached);

__PACKAGE__->meta->make_immutable;

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

# Memcached doesn't support get_keys. For testing purposes, define get_keys
# and clear by checking for all keys used during testing. Note, some keys
# are changed in CHIDriverTests::set_standard_keys_and_values.
#
my @all_test_keys =
  ( CHI::t::Driver->all_test_keys(), 'mixed', 'space', scalar( 'ab' x 100 ) );

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
