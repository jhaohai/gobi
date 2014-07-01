package OFPMatch;

use strict;
use warnings;

use OFPOXMTLV;

my $type;
my $length;
my @oxm_fields;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    $self->{type} = 1;
    return $self;
}

sub decode {
    my $self = shift;
    my $buf = shift;
    ($self->{type}, $self->{length}) = unpack("n n", substr($buf, 0, 4));
    my $oxm = substr($buf, 4);
    while(length($oxm)) {
        my $oxmtlv = OFPOXMTLV->new();
        $oxm = $oxmtlv->decode($oxm);
        $self->add($oxmtlv);
    }
}

sub add {
    my $self = shift;
    my $oxmtlv = shift;
    push(@{$self->{oxm_fields}}, $oxmtlv);
}

sub encode {
    my $self = shift;
    my $body = "";
    foreach my $oxmtlv (@{$self->{oxm_flelds}}) {
        $body .= $oxmtlv->encode();
    }
    my $len = length($body) + 4;
    my $pad_len = int(($len + 7) / 8) * 8 - $len;
    my $buf = pack("n n", $self->{type}, $len).$body.pack("x$pad_len");
    return $buf;
}


1;
