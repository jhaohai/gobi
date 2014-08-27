package Verdict;

use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    $self->{prison} = [];
    return $self;
}

sub put {
    my $self = shift;
    my $prisoner = shift;
    push(@{$self->{prison}}, $prisoner);
}

sub Judge {
    
}


1;
