#!/usr/bin/perl

use strict;
use warnings;
use autodie;
use IO::Socket::INET;
use IO::Select;
use Class::Struct;

use protocol10;

my $server = IO::Socket::INET->new(
    Proto       => "tcp",
    LocalPort   => protocol10::OFP_TCP_PORT,
    Listen      => SOMAXCONN
) or die "Cannot initiate socket: $!\n";
my $select = IO::Select->new($server);
my $of = protocol10->new();
my $data;

print "Gobi Started\n";

while (1) {
    #my @ready = $select->can_read(0);
    
    foreach my $sock ($select->can_read(0)) {
        if($sock == $server) {
            my $new = $server->accept();
            $select->add($new);
        }
        else {
            if($of->proc($sock) != 0) {
                $select->remove($sock);
                $sock->close();
            }
        }
    }
    
}




