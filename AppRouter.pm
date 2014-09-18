package AppRouter;

use strict;
use warnings;

my $level = 1;
my $valid = 0;
my $ofpmod;

sub execute {
    shift;
    my ($switch, $packet_in) = @_;
    my $in_port = $packet_in->{match}->{oxm_fields}->[0]->{oxm_value};
    my $dpid = $switch->{dpid};
    
    
}
