package AppSwitch;

use strict;
use warnings;

use OFPPacketOut;
use OFPFlowMod;
use OFPOXMTLV;
use Net::Packet::Consts qw(:eth :arp);

my $level = 1;
my $valid = 0;
my $ofpmod;

my $mactable = {};

sub execute {
    shift;
    print "Switch\n";
    my ($switch, $packet_in) = @_;
    my $in_port = $packet_in->{match}->{oxm_fields}->[0]->{oxm_value};
    my $dpid = $switch->{dpid};
    my $dst = $packet_in->{data}->dst;
    my $src = $packet_in->{data}->src;
    
    my $result = {};
    $result->{priority} = 1;
    $result->{valid} = 0;
    if($dst ne "ff:ff:ff:ff:ff:ff") {
        $mactable->{$dpid}{$src} = $in_port;
    }
    
    if(($packet_in->{data}->type == NP_ETH_TYPE_IPv4) && ($dst eq "ff:ff:ff:ff:ff:ff")) {
        $result->{valid} = 0;
        return $result;
    }
    
    if(exists($mactable->{$dpid}{$dst})) {
        my $ofpmod = OFPFlowMod->new();
        my $ofpmatch = OFPMatch->new();
        my $oxmtlv = OFPOXMTLV->new();
        $oxmtlv->set(0x03, $dst);
        $ofpmatch->add($oxmtlv);
        $ofpmod->set($ofpmatch);
        my $ofpinst = OFPINSTACT->new();
        my $ofpact = OFPACTOUT->new();
        $ofpact->set($mactable->{$dpid}{$dst});
        $ofpinst->add($ofpact);
        $ofpmod->{priority} = 1;
        $ofpmod->add($ofpinst);
        $result->{out} = $ofpmod->encode();
        $result->{valid} = 1;
    }
    else {
        my $packet_out = OFPPacketOut->new();
        $packet_out->{buffer_id} = $packet_in->{buffer_id};
        $packet_out->{in_port} = $in_port;
        my $ofpact = OFPACTOUT->new();
        $ofpact->set(0xfffffffc);
        $packet_out->add($ofpact);
        $result->{out} = $packet_out->encode();
        $result->{valid} = 1;
    }
    return $result;
}


1;
