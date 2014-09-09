package OFPHeader;

use strict;
use warnings;

my $version;
my $type;
my $length;
my $xid;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    $self->{version} = 0x04;
    $self->{xid} = 0;
    return $self;
}

sub encode {
    my $self = shift;
    return pack("C C n N", $self->{version}, $self->{type}, $self->{length}, $self->{xid});
}

sub decode {
    my $self = shift;
    ($self->{version}, $self->{type}, $self->{length}, $self->{xid}) = unpack("C C n N", shift);
}



1;
