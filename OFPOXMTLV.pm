package OFPOXMTLV;

use strict;
use warnings;
use Data::Dumper;

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
        my @eth = unpack("H2" x 6, substr($buf, 4, $self->{oxm_length}));
        $self->{oxm_value} = join(":", @eth);
    }
    elsif($self->{oxm_field} == 0x04) {
        my @eth = unpack("H2" x 6, substr($buf, 4, $self->{oxm_length}));
        $self->{oxm_value} = join(":", @eth);
    }
    elsif($self->{oxm_field} == 0x05) {
        $self->{oxm_value} = unpack("n", substr($buf, 4, $self->{oxm_length}));
    }
    elsif($self->{oxm_field} == 0x0b) {
        my @ip = unpack("C" x 4, substr($buf, 4, $self->{oxm_length}));
        $self->{oxm_value} = join(".", @ip);
    }
    elsif($self->{oxm_field} == 0x0c) {
        my @ip = unpack("C" x 4, substr($buf, 4, $self->{oxm_length}));
        $self->{oxm_value} = join(".", @ip);
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
        $self->{oxm_length} = 6;
    }
    elsif($self->{oxm_field} == 0x04) {
        $self->{oxm_length} = 6;
    }
    elsif($self->{oxm_field} == 0x05) {
        $self->{oxm_length} = 2;
    }
    elsif($self->{oxm_field} == 0x0b) {
        $self->{oxm_length} = 4;
    }
    elsif($self->{oxm_field} == 0x0c) {
        $self->{oxm_length} = 4;
    }
    else {
        $self->{oxm_length} = length($self->{oxm_value});
    }
}

sub encode {
    my $self = shift;
    my $oxm_fh = $self->{oxm_field} * 2 + $self->{oxm_hasmask};
    my $buf = pack("n C C", $self->{oxm_class}, $oxm_fh, $self->{oxm_length});
    my $value;
    if($self->{oxm_field} == 0x00) {
        $value = pack("N", $self->{oxm_value});
    }
    elsif($self->{oxm_field} == 0x03) {
        my @eth = split(":", $self->{oxm_value});
        print Dumper(@eth);
        $value = pack("H2" x 6, @eth);
    }
    elsif($self->{oxm_field} == 0x04) {
        my @eth = split(":", $self->{oxm_value});
        $value = pack("H2" x 6, @eth);
    }
    elsif($self->{oxm_field} == 0x05) {
        $value = pack("n", $self->{oxm_value});
    }
    elsif($self->{oxm_field} == 0x0b) {
        my @ip = split(/\./, $self->{oxm_value});
        $value = pack("C" x 4, @ip);
    }
    elsif($self->{oxm_field} == 0x0c) {
        my @ip = split(/\./, $self->{oxm_value});
        print Dumper(@ip);
        $value = pack("C" x 4, @ip);
    }
    $buf .= $value;
    return $buf;
}


1;
