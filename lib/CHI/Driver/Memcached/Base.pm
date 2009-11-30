package CHI::Driver::Memcached::Base;
use CHI;
use Carp;
use Moose;
use strict;
use warnings;

our $VERSION = '0.10';

has 'memd' => ( is => 'ro', init_arg => undef );
has 'memd_class'  => ( is => 'ro' );
has 'memd_params' => ( is => 'ro' );

extends 'CHI::Driver::Base::CacheContainer';

# Unsupported methods
#
__PACKAGE__->declare_unsupported_methods(
    qw(dump_as_hash get_keys get_namespaces is_empty clear purge));

__PACKAGE__->meta->make_immutable();

sub BUILD {
    my ( $self, $params ) = @_;

    $self->{memd_params} ||= $self->non_common_constructor_params($params);
    $self->{memd_params}->{namespace} ||= $self->{namespace} . ":";
    $self->{memd} = $self->{_contained_cache} = $self->_build_contained_cache;
}

sub _build_contained_cache {
    my ($self) = @_;

    Class::MOP::load_class( $self->memd_class );
    return $self->memd_class->new( $self->memd_params );
}

# Memcached supports fast multiple get
#

sub fetch_multi_hashref {
    my ( $self, $keys ) = @_;
    croak "must specify keys" unless defined($keys);

    return $self->memd->get_multi(@$keys);
}

1;
