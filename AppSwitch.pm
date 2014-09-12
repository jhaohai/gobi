package AppSwitch;

use strict;
use warnings;

use ETHType;
use OFPPacketOut;
use OFPFlowMod;
use OFPOXMTLV;

my $level = 1;
my $valid = 0;
my $ofpmod;

my $table = {};

sub execute {
    shift;
    my ($switch, $packet_in) = @_;
    my $in_port = $packet_in->{match}->{oxm_fields}->[0]->{oxm_value};
    my $dpid = $switch->{dpid};
    my $dst = $packet_in->{data}->{mac_dst};
    my $src = $packet_in->{data}->{mac_src};
    
    $table->{$dpid}{$src} = $in_port;
    
    my $result = {};
    $result->{priority} = 1;
    
    if(exists($table->{$dpid}{$dst})) {
        my $ofpmod = OFPFlowMod->new();
        my $ofpmatch = OFPMatch->new();
        my $oxmtlv = OFPOXMTLV->new();
        $oxmtlv->set(0x03, $dst);
        $ofpmatch->add($oxmtlv);
        $ofpmod->set($ofpmatch);
        my $ofpinst = OFPINSTACT->new();
        my $ofpact = OFPACTOUT->new();
        $ofpact->set($table->{$dpid}{$dst});
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
}


1;
