package AppRouter;

use strict;
use warnings;

use Net::Packet;
use Net::Packet::Consts qw(:eth :arp);

my $level = 1;
my $valid = 0;
my $ofpmod;

my $arptable = {};
my $routetable = {};
my $switchtable = {};
my $iptable = {};

sub execute {
    shift;
    my ($switch, $packet_in) = @_;
    my $in_port = $packet_in->{match}->{oxm_fields}->[0]->{oxm_value};
    my $dpid = $switch->{dpid};
    my $dst_mac = $packet_in->{data}->{dst};
    my $src_mac = $packet_in->{data}->{src};
    
    my $result = {};
    $result->{priority} = 1;
    
    if($packet_in->{data}->{type} == NP_ETH_TYPE_IPV4) {
        my $ip_in = Net::Packet::IPv4->new(raw => $packet_in->{data}->payload);
        my $src_ip = $ip_in->src;
        my $dst_ip = $ip_in->dst;
        
        $arptable->{$dpid}{$src_ip} = $src_mac;
        $routetable->{$dpid}{$src_ip} = $in_port;
        
        if(exists($arptable->{$dpid}{$dst_ip}) && exists($routetable->{$dpid}{$dst_ip})) {
            my $new_dst_mac = $arptable->{$dpid}{$dst_ip};
            my $out_port = $routetable->{$dpid}{$dst_ip};
            my $new_src_mac = $swtichtable->{$dpid};
            if($out_port == $in_port) {
                $result->{valid} = 0
                return $result;
            }
            my $ofpmod = OFPFlowMod->new();
            my $ofpmatch = OFPMatch->new();
            my $oxmtlv = OFPOXMTLV->new();
            $oxmtlv->set(0x0c, $dst_ip);
            $ofpmatch->add($oxmtlv);
            $ofpmod->set($ofpmatch);
            my $ofpinst = OFPINSTACT->new();
            my $ofpactset_dst = OFPACTSET->new();
            my $ofpactset_src = OFPACTSET->new();
            my $ofpactout = OFPACTOUT->new();
            $ofpactset_dst->set(0x03, $new_dst_mac);
            $ofpactset_src->set(0x04, $new_src_mac);
            $ofpactout->set($out_port);
            $ofpinst->add($ofpactset_dst);
            $ofpinst->add($ofpactset_src);
            $ofpinst->add($ofpactout);
            $ofpmod->add($ofpinst);
            $result->{valid} = 1;
            $result->{out} = $ofpmod->encode();
        }
        else {
            my $new_dst_mac = NP_ETH_ADDR_BROADCAST;
            my $out_port = 0xfffffffc;
            my $new_src_mac = $switchtable->{$dpid};
            my $packet_out = OFPPacketOut->new();
            $packet_out->{buffer_id} = $packet_in->{buffer_id};
            $packet_out->{in_port} = $in_port;
            my $ofpactset_dst = OFPACTSET->new();
            my $ofpactset_src = OFPACTSET->new();
            my $ofpactout = OFPACTOUT->new();
            $ofpactset_dst->set(0x03, $new_dst_mac);
            $ofpactset_src->set(0x04, $new_src_mac);
            $ofpactout->set($out_port);
            $packet_out->add($ofpactset_dst);
            $packet_out->add($ofpactset_src);
            $packet_out->add($ofpactout);
            $result->{out} = $packet_out->encode();
            $result->{valid} = 1;
        }
        return $result;
    }
}
