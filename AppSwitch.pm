package AppSwitch;

use strict;
use warnings;

use ETHType;
use OFPPacketOut;

my $level = 1;
my $valid = 0;
my $ofpmod;

my $table = {};

sub execute {
    my ($switch, $packet_in) = @_;
    my $in_port = $packet_in->{match}->{oxm_fields}->[0]->{value};
    my $dpid = $switch->{dpid};
    my $dst = $packet_in->{data}->{mac_dst};
    my $src = $packet_in->{data}->{mac_src};
    
    $table->{$dpid}{$src} = $in_port;
    
    if(exists($table->{$dpid}{$dst})) {
        
    }
    else {
        my $packet_out = OFPPacketOut->new();
        $packet_out->{buffer_id} = $packet_in->{buffer_id};
        $packet_out->{in_port} = $in_port;
        my $ofpact = OFPACTOUT->new();
        $ofpact->set(0xfffffffc);
        $packet_out->add($ofpact);
        $switch->flow($packet_out->encode());
    }
}
