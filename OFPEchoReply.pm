package OFPEchoReply;

use strict;
use warnings;

use OFPType;
use OFPHeader;

my $header;


sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    $self->{header} = OFPHeader->new();
    $self->{header}->{type} = OFPType->OFPT_ECHO_REPLY;
    $self->{header}->{length} = 8;
    $self->{header}->{xid} = 0;
    return $self;
}

sub encode {
    my $self = shift;
    return $self->{header}->encode();
}


1;
