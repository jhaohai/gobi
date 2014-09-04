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
    $self->{actions_len} = 0;
    $self->{actions} = [];
    return $self;
}

sub add {
    my $self = shift;
    my $action = shift;
    push(@{$self->{actions}}, $action);
    $self->{actions_len} += length($action->encode());
}

sub encode {
    my $self = shift;
    my $buf = $self->{header}->encode();
    $buf .= pack("N N n x6", $self->{buffer_id}, $self->{in_port}, $self->{actions_len});
    for my $action (@{$self->{actions}}) {
        $buf .= $action->enocde();
    }
    return $buf;
}



1;
