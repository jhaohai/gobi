package Ethernet;

use strict;
use warnings;

my $mac_dst;
my $mac_src;
my $eth_type;
my $payload;

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
}


1;

=pod
ffffffffffff
002320f561d0
8035
0001
0800
0604
0003
002320f561d0
00000000
002320f561d0
00000000
=cut
