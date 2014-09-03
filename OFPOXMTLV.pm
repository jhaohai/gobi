package OFPOXMTLV;

use strict;
use warnings;

my $oxm_class;
my $oxm_field;
my $oxm_hasmask;
my $oxm_length;
my $oxm_value;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    return $self;
}

sub decode {
    my $self = shift;
    my $buf = shift;
    my $oxm_fh;
    ($self->{oxm_class}, $oxm_fh, $self->{oxm_length}) = unpack("n C C", substr($buf, 0, 4));
    $self->{oxm_field} = int($oxm_fh/2);
    $self->{oxm_hasmask} = $oxm_fh%2;
    if($self->{oxm_field} == 0x00) {
        $self->{oxm_value} = unpack("N", substr($buf, 4, $self->{oxm_length}));
    }
    elsif($self->{oxm_field} == 0x03) {
        $self->{oxm_value} = unpack("H12", substr($buf, 4, $self->{oxm_length}));
    }
    elsif($self->{oxm_field} == 0x04) {
        $self->{oxm_value} = unpack("H12", substr($buf, 4, $self->{oxm_length}));
    }
    elsif($self->{oxm_field} == 0x05) {
        $self->{oxm_value} = unpack("n", substr($buf, 4, $self->{oxm_length}));
    }
    else {
        $self->{oxm_value} = substr($buf, 4, $self->{oxm_length});
    }
    return substr($buf, 4 + $self->{oxm_length});
}

sub set {
    my $self = shift;
    $self->{oxm_field} = shift;
    $self->{oxm_value} = shift;
    $self->{oxm_class} = 0x8000;
    $self->{oxm_hasmask} = 0;
    if($self->{oxm_field} == 0x00) {
        $self->{oxm_length} = 4;
    }
    elsif($self->{oxm_field} == 0x03) {
        $self->{oxm_value} = 6;
    }
    elsif($self->{oxm_field} == 0x04) {
        $self->{oxm_value} = 6;
    }
    elsif($self->{oxm_field} == 0x05) {
        $self->{oxm_value} = 2;
    }
    else {
        $self->{oxm_length} = length($self->{oxm_value});
    }
}

sub encode {
    my $self = shift;
    my $oxm_fh = $self->{oxm_field} * 2 + $self->{oxm_hasmask};
    my $buf = pack("n C C", $self->{oxm_class}, $oxm_fh, $self->{oxm_length});
    if($self->{oxm_field} == 0x00) {
        $self->{oxm_value} = pack("N", $self->{value});
    }
    elsif($self->{oxm_field} == 0x03) {
        $self->{oxm_value} = pack("H12", substr($buf, 4, $self->{oxm_value}));
    }
    elsif($self->{oxm_field} == 0x04) {
        $self->{oxm_value} = pack("H12", substr($buf, 4, $self->{oxm_value}));
    }
    elsif($self->{oxm_field} == 0x05) {
        $self->{oxm_value} = pack("n", substr($buf, 4, $self->{oxm_value}));
    }
    $buf .= $self->{oxm_value};
    return $buf;
}


1;
