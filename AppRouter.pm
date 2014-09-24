package AppRouter;

use strict;
use warnings;

use Net::Packet;
use Net::Packet::Consts qw(:eth);

my $level = 1;
my $valid = 0;
my $ofpmod;

sub execute {
    shift;
    my ($switch, $packet_in) = @_;
    my $in_port = $packet_in->{match}->{oxm_fields}->[0]->{oxm_value};
    my $dpid = $switch->{dpid};
    
    if($packet_in->{data}->{type} == NP_ETH_TYPE_ARP) {
        
    }
    else if($packet_in->{data}->{type} == NP_ETH_TYPE_IPV4) {
        
    }
}
