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
    
    if($packet_in->{data}->{type} == NP_ETH_TYPE_ARP) {
        my $arp_in = Net::Packet::ARP->new(raw => $packet_in->{data}->payload);
        $src_ip = $arp_in->srcIp;
        $dst_ip = $arp_in->dstIp;
        $src_mac = $arp_in->src;
        $dst_mac = $arp_in->dst;
        
        $arptable->{$dpid}{$src_ip} = $src_mac;
        $routetable->{$dpid}{$src_ip} = $in_port;
        
        if(exists($arptable->{$dpid}{$dst_ip}) && exists($routetable->{$dpid}{$dst_ip})) {
            
        }
        
        if($arp_in->opCode == NP_ARP_OPCODE_REQUEST) {
            if(exists($arptable->{$dpid}{$dst_ip}) && exists($routetable->{$dpid}{$dst_ip})) {
                my $arp_out = Net::Packet::ARP->new(opCode => NP_ARP_OPCODE_REPLY, src => $switchtable->{$dpid}, dst => $src_mac, srcIp => $dst_ip, dstIp => $src_ip);
                my $eth_out = Net::Packet::ETH->new(src => $switchtable->{$dpid}, dst => $dst_mac, type => NP_ETH_TYPE_ARP);
                my $frame = Net::Packet::Frame->new(l2 => $eth_out, l3 => $arp_out);
                $frame->pack;
                #TODO packet out
            }
            else {
                my $arp_out = Net::Packet::ARP->new(opCode => NP_ARP_OPCODE_REPLY, src => $switchtable->{$dpid}, srcIp => $)
                #TODO packet out
            }
        }
        else if($arp_in->opCode == NP_ARP_OPCODE_REPLY) {
            
        }
    }
    else if($packet_in->{data}->{type} == NP_ETH_TYPE_IPV4) {
        my $ip_in = Net::Packet::IPv4->new(raw => $packet_in->{data}->payload);
        my $src_ip = $ip_in->src;
        my $dst_ip = $ip_in->dst;
        
        $arptable->{$dpid}{$src_ip} = $src_mac;
        $routetable->{$dpid}{$src_ip} = $in_port;
        
        if(exists($arptable->{$dpid}{$dst_ip}) && exists($routetable->{$dpid}{$dst_ip})) {
            my $new_dst_mac = $arptable->{$dpid}{$dst_ip};
            my $out_port = $routetable->{$dpid}{$dst_ip};
            my $new_src_mac = $swtichtable->{$dpid};
        }
        else {
            my $new_dst_mac = NP_ETH_ADDR_BROADCAST;
            my $out_port = 0xfffffffc;
            my $new_src_mac = $switchtable->{$dpid};
        }
    }
}
