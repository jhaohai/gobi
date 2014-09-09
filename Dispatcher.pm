package Dispatcher;

use strict;
use warnings;

use AppSwitch;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    return $self;
}

sub inittable {
    my $self = shift;
    $self->{"0000000000000000"} = ["AppSwitch"];
    $self->{"0000000000000001"} = ["AppSwitch"];
}

sub dispatch {
    my $self = shift;
    my $switch = shift;
    my $packet_in = shift;
    my $dpid = $switch->{dpid};
    my $collection = [];
    
    foreach my $app (@{$self->{$dpid}}) {
        #eval "require $app";
        #push(@{$collection}, $app->execute($switch, $packet_in));
        $app->execute($switch, $packet_in);
    }
    
    return $collection;
}

1;
