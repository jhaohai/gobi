package AppHub;

use strict;
use warnings;

use OFPFlowMod;
use OFPMatch;
use OFPINSTACT;
use OFPACTOUT;

sub execute {
    my ($sock, $packet_in) = @_;
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

1;
