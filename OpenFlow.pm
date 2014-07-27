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

use AppHub;

my $select;
my $server;
my %switches;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    return $self;
}

sub init {
    my $self = shift;
    $server = IO::Socket::INET->new(
        Proto       => "tcp",
        LocalPort   => 6633,
        ReuseAddr   => 1,
        Listen      => SOMAXCONN,
    ) or die "Cannot Initiate Socket: $!\n";
    $select = IO::Select->new($server);
}

sub start {
    my $self = shift;
    while (1) {
        foreach my $sock ($select->can_read()) {
            if($sock == $server) {
                handle_new();
            }
            else {
                handle_switch($sock);
            }
        }  
    }
}

sub handle_new {
    print "New Switch In\n";
    
    my $new = $server->accept();
   
    my $ofp_hello = OFPHello->new();
    $new->send($ofp_hello->encode());
    $select->add($new);
                
    my $switch = OFPSwitch->new();
    $switch->{sock} = $new;
    $switches{$new} = $switch;
}

sub handle_switch {
    my $sock = shift;
    my $switch = $switches{$sock};
    
    print $switch->{dpid}.":";
    
    $sock->recv(my $buf, 2048);
    
    if(length($buf) < 8) {
        print "Malformed Msg\n";
        delete_switch($sock);
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
    }
    elsif($ofp_header->{type} == OFPType->OFPT_PACKET_IN) {
        print "PACKET_IN\n";
        my $ofp_packet_in = OFPPacketIn->new();
        $ofp_packet_in->decode($ofp_header, $ofp_data);
        #handle_packetin($sock, $ofp_packet_in);
        my $ofpmod = OFPFlowMod->new();
        my $ofpmatch = OFPMatch->new();
        $ofpmod->set($ofpmatch);
        my $ofpinst = OFPINSTACT->new();
        my $ofpact = OFPACTOUT->new();
        $ofpact->set(0xfffffffc);
        $ofpinst->add($ofpact);
        $ofpmod->add($ofpinst);
        $sock->send($ofpmod->encode());
    }
    elsif($ofp_header->{type} == OFPType->OFPT_MULTIPART_REPLY) {

    }

}

sub delete_switch {
    my $sock = shift;
    $select->remove($sock);
    delete $switches{$sock};
    $sock->close();
}

sub handle_packetin {
    my $sock = shift;
    my $ofp_packet_in = shift;
    AppHub->execute($sock, $ofp_packet_in);
    print unpack("H*", $ofp_packet_in->{data});
    print "\n";
}


1;
