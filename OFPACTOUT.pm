package OFPACTOUT;

use strict;
use warnings;

my $type;
my $len;
my $port;
my $max_len;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
}

sub set {
    my $self = shift;
    $self->{type} = 0;
    $self->{len} = 16;
    $self->{port} = shift;
    $self->{max_len} = 0xffe5;
}

sub encode {
    my $self = shift;
    my $buf = pack("n n N n x6", $self->{type}, $self->{len}, $self->{port}, $self->{max_len});
    return $buf;
}

1;
