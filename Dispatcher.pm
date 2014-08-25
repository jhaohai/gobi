package Dispatcher;

use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    return $self;
}

sub inittable {
    my $self = shift;
    $self->{"0000000000000000"} = ["AppHub", "AppFirewall"];
    $self->{"0000000000000001"} = ["AppSwitch", "AppFirewall"];
}

sub execute {
    my $self = shift;
}

1;
