package OFPFlowMod;

use strict;
use warnings;

use OFPType;
use OFPHeader;

my $header;
my $cookie;
my $cookie_mask;
my $table_id;
my $command;
my $idle_timeout;
my $hard_timeout;
my $priority;
my $buffer_id;
my $out_port;
my $out_group;
my $match;
my $insts;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    $self->{header} = OFPHeader->new();
    $self->{header}->{type} = OFPType->OFPT_FLOW_MOD;
    $self->{header}->{xid} = 0;
    return $self;
}

sub set {
    my $self = shift;
    $self->{cookie} = 0;
    $self->{cookie_mask} = 0;
    $self->{table_id} = 0;
    $self->{command} = 0;
    $self->{idle_timeout} = 1;
    $self->{hard_timeout} = 1;
    $self->{priority} = 0x8000;
    $self->{buffer_id} = 0xffffffff;
    $self->{out_port} = 0;
    $self->{out_group} = 0;
    $self->{flags} = 0;
    $self->{match} = shift;
    $self->{insts} = shift;
}
