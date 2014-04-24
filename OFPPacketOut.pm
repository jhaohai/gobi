package OFPPacketOut;

use strict;
use warnings;

use OFPHeader;

my $header;
my $buffer_id;
my $in_port;
my $actions_len;
my @actions;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    $self->{header} = OFPHeader->new();
    $self->{header}->{type} = OFPType->OFPT_PACKET_OUT;
    return $self;
}



1;
