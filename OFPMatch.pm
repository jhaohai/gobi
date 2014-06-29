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
        push(@{$self->{oxm_fields}}, $oxmtlv);
    }
}

sub set {
    
}

sub encode {
    my $self = shift;
}


1;
