package OFPINSTACT;

use strict;
use warnings;

my $type;
my $len;
my $actions;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    $self->{type} = 4;
    $self->{len} = 8;
    return $self;
}

sub add {
    my $self = shift;
    my $act = shift;
    push(@{$self->{actions}}, $act);
    $self->{len} += $act->{len};
}

sub encode {
    my $self = shift;
    my $buf = pack("n n x4", $self->{type}, $self->{len});
    foreach my $act (@{$self->{actions}}) {
        $buf .= $act->encode();
    }
    return $buf;
}


1;
