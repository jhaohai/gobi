package OFPACTSET;

use strict;
use warnings;

my $type;
my $len;
my $oxmtlv;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
}

sub set {
    my $self = shift;
    my $type = shift;
    my $value = shift;
    $self->{oxmtlv} = OFPOXMTLV->new();
    $self->{oxmtlv}->set($type, $value);
    $self->{type} = 0x19;
    $self->{len} = int((($self->{oxmtlv}->{oxm_length} + 8) + 7) / 8) * 8;
}

sub encode {
    my $self = shift;
    my $xlen = $self->{len} - 8 - $self->{oxmtlv}->{oxm_length};
    my $buf = pack("n n", $self->{type}, $self->{len});
    $buf .= $self->{oxmtlv}->encode();
    $buf .= pack("x$xlen");
    return $buf;
}


1;
