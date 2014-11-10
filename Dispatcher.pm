package Dispatcher;

use strict;
use warnings;

use AppSwitch;
use AppRouter;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    return $self;
}

sub inittable {
    my $self = shift;
    $self->{"0000000000000001"} = ["AppSwitch"];
    $self->{"0000000000000002"} = ["AppRouter"];
}

sub dispatch {
    my $self = shift;
    my $switch = shift;
    my $packet_in = shift;
    my $dpid = $switch->{dpid};
    my $results = [];
    
    foreach my $app (@{$self->{$dpid}}) {
        push(@{$results}, $app->execute($switch, $packet_in));
        #$app->execute($switch, $packet_in);
    }
    
    return $results;
}

1;
