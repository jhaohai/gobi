package OpenFlow;

use strict;
use warnings;

use IO::Socket::INET;
use IO::Select;

use OFPHello;
use OFPHeader;
use OFPType;
use OFPFeaturesRequest;
use OFPEchoReply;
use OFPFeaturesReply;
use OFPPacketIn;
use OFPSwitch;
use Dispatcher;
use OFPFlowMod;
use OFPINSTACT;
use OFPACTOUT;
use OFPACTSET;
use OFPOXMTLV;
use Net::Packet::Consts qw(:eth);
use Verdict;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    return $self;
}

sub init {
    my $self = shift;
    my $server = IO::Socket::INET->new(
        Proto       => "tcp",
        LocalPort   => 6633,
        ReuseAddr   => 1,
        Listen      => SOMAXCONN,
    ) or die "Cannot Initiate Socket: $!\n";
    $self->{server} = $server;
    $self->{select} = IO::Select->new($server);
    $self->{switches} = {};
    $self->{dispatcher} = Dispatcher->new();
    $self->{dispatcher}->inittable();
}

sub start {
    my $self = shift;
    while (1) {
        foreach my $sock ($self->{select}->can_read()) {
            if($sock == $self->{server}) {
                $self->handle_new($sock);
            }
            else {
                $self->handle_switch($sock);
            }
        }  
    }
}

sub handle_new {
    print "New Switch In\n";
    my $self = shift;
    my $sock = shift;
    my $new = $sock->accept();
    
    my $ofp_hello = OFPHello->new();
    $new->send($ofp_hello->encode());
    $self->{select}->add($new);
                
    my $switch = OFPSwitch->new();
    $switch->{sock} = $new;
    $self->{switches}->{$new} = $switch;
}

sub handle_switch {
    my $self= shift;
    my $sock = shift;
    my $switch = $self->{switches}->{$sock};
    
    print $switch->{dpid}.":";
    
    $sock->recv(my $buf, 2048);
    
    if(length($buf) < 8) {
        print "Malformed Msg\n";
        $self->delete_switch($sock);
        return;
    }
    
    my $ofp_header = OFPHeader->new();
    $ofp_header->decode(substr($buf, 0, 8));
      
    if($ofp_header->{version} != 0x04) {
        print "OpenFlow 1.3 Only!\n";
        return;
    }
    
    my $ofp_data = substr($buf, 8);

    if($ofp_header->{type} == OFPType->OFPT_HELLO) {
        print "HELLO\n";
        my $ofp_features_request = OFPFeaturesRequest->new();
        $sock->send($ofp_features_request->encode());
    }
    elsif($ofp_header->{type} == OFPType->OFPT_ERROR) {
        print "ERROR\n";
    }
    elsif($ofp_header->{type} == OFPType->OFPT_ECHO_REQUEST) {
        print "ECHO_REQUEST\n";
        my $ofp_echo_reply = OFPEchoReply->new();
        $sock->send($ofp_echo_reply->encode());
    }
    elsif($ofp_header->{type} == OFPType->OFPT_FEATURES_REPLY) {
        print "FEATURES_REPLY\n";
        my $ofp_switch_features = OFPFeaturesReply->new();
        $ofp_switch_features->decode($ofp_header, $ofp_data);
        $switch->set($ofp_switch_features);
        $self->disable_ipv6($switch);
        $self->default_flow($switch);
    }
    elsif($ofp_header->{type} == OFPType->OFPT_PACKET_IN) {
        print "PACKET_IN\n";
        my $packet_in = OFPPacketIn->new();
        $packet_in->decode($ofp_header, $ofp_data);
        my $results = $self->{dispatcher}->dispatch($switch, $packet_in);
        my $final = Verdict->judge($results);
        if($final->{valid} == 1) {
            $switch->sendto($final->{out});
        }
    }
    elsif($ofp_header->{type} == OFPType->OFPT_MULTIPART_REPLY) {

    }

}

sub default_flow {
    my $self = shift;
    my $switch = shift;
    my $ofpmod = OFPFlowMod->new();
    my $ofpmatch = OFPMatch->new();
    $ofpmod->set($ofpmatch);
    my $ofpinst = OFPINSTACT->new();
    my $ofpact = OFPACTOUT->new();
    $ofpact->set(0xfffffffd);
    $ofpinst->add($ofpact);
    $ofpmod->{priority} = 0x0000;
    $ofpmod->add($ofpinst);
    $switch->sendto($ofpmod->encode());
}

sub disable_ipv6 {
    my $self = shift;
    my $switch = shift;
    my $ofpmod = OFPFlowMod->new();
    my $ofpmatch = OFPMatch->new();
    my $oxmtlv = OFPOXMTLV->new();
    $oxmtlv->set(0x05, NP_ETH_TYPE_IPv6);
    $ofpmatch->add($oxmtlv);
    $ofpmod->set($ofpmatch);
    $ofpmod->{priority} = 0x0000;
    $switch->sendto($ofpmod->encode());
}

sub delete_switch {
    my $self = shift;
    my $sock = shift;
    $self->{select}->remove($sock);
    delete $self->{switches}->{$sock};
    $sock->close();
}

sub handle_packetin {
    my $sock = shift;
    my $packet_in = shift;
    AppHub->execute($sock, $packet_in);
    print unpack("H*", $packet_in->{data});
    print "\n";
}


1;
