package Ethernet;

use strict;
use warnings;

use ETHType;

my $mac_dst;
my $mac_src;
my $eth_type;
my $payload;
my $ip_src;
my $ip_dst;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    return $self;
}

sub decode {
    my $self = shift;
    my $data = shift;
    ($self->{mac_dst}, $self->{mac_src}, $self->{eth_type}) = unpack("H12 H12 n", substr($data, 0, 14));
    $self->{payload} = substr($data, 14);
    if($self->{eth_type} == ETHType::ETH_IPV4) {
        ($self->{ip_src}, $self->{ip_dst}) = unpack("H8 H8", substr($data, 26, 8));
    }
}


1;
