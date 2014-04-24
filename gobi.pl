#!/usr/bin/perl
package gobi;

use strict;
use warnings;
use IO::Socket::INET;
use IO::Select;
use Class::Struct;

use protocol13;

my $of = protocol13->new();

my $server = IO::Socket::INET->new(
    Proto       => "tcp",
    #LocalPort   => $of->OFP_TCP_PORT,
    LocalPort   => 6633,
    ReuseAddr   => 1,
    Listen      => SOMAXCONN,
) or die "Cannot initiate socket: $!\n";
my $select = IO::Select->new($server);

print "Gobi Started\n";

while (1) {
    foreach my $sock ($select->can_read()) {
        if($sock == $server) {
            my $new = $server->accept();
            my $ofp_header = $of->ofp_hello_encode();
            $new->send($ofp_header);
            $select->add($new);
        }
        else {
            $sock->recv(my $buf, 2048);
            if($buf) {
                if(length($buf) < 8) {
                    print "Malformed\n"
                }
                else {                    
                    my $ofp_header = $of->ofp_header_decode(substr($buf, 0, $of->OFP_HEADER_LEN));
                    my $ofp_data = substr($buf, $of->OFP_HEADER_LEN);
                    if($ofp_header->type == $of->OFPT_HELLO) {
                        if($ofp_header->version != $of->OFP_VERSION) {
                            $select->remove($sock);
                            $sock->close();
                            next;
                        }
                        my $ofp_features_request = $of->ofp_features_request_encode();
                        $sock->send($ofp_features_request);
                    }
                    elsif($ofp_header->type == $of->OFPT_ERROR) {
                        print "OFP ERROR\n";
                    }
                    elsif($ofp_header->type == $of->OFPT_ECHO_REQUEST) {
                        my $ofp_echo_reply = $of->ofp_echo_reply_encode();
                        $sock->send($ofp_echo_reply);
                    }
                    elsif($ofp_header->type == $of->OFPT_FEATURES_REPLY) {
                        my $ofp_switch_features = $of->ofp_switch_features_decode($ofp_header, $ofp_data);
                    }
                    elsif($ofp_header->type == $of->OFPT_PACKET_IN) {
                        my $ofp_packet_in = $of->ofp_packet_in_decode($ofp_header, $ofp_data);
                        
                    }
                    elsif($ofp_header->type == $of->OFPT_MULTIPART_REPLY) {
                        print "multipart reply\n";
                    }
                }
            }
            else {
                $select->remove($sock);
                $sock->close();
            }
        }
    }  
}



