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
    $self->{idle_timeout} = 5;
    $self->{hard_timeout} = 0;
    $self->{priority} = 0x8000;
    $self->{buffer_id} = 0xffffffff;
    $self->{out_port} = 0;
    $self->{out_group} = 0;
    $self->{flags} = 0;
    $self->{match} = shift;
    $self->{header}->{length} = 48 + length($self->{match}->encode());
}

sub add {
    my $self = shift;
    my $inst = shift;
    push(@{$self->{insts}}, $inst);
    $self->{header}->{length} += $inst->{len};
}

sub encode {
    my $self = shift;
    my $buf = pack("H16 H16 C C n n n N N N n x2", $self->{cookie}, $self->{cookie_mask}, $self->{table_id}, $self->{command}, $self->{idle_timeout}, $self->{hard_timeout}, $self->{priority}, $self->{buffer_id}, $self->{out_port}, $self->{out_group}, $self->{flags});
    $buf = $self->{header}->encode().$buf;
    $buf .= $self->{match}->encode();
    foreach my $inst (@{$self->{insts}}) {
        $buf .= $inst->encode();
    }
    return $buf;
}

1;
