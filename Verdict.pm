package Verdict;

use strict;
use warnings;

my @prison = ();

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    return $self;
}

sub put {
    my $prisoner = shift;
    push(@prison, $prisoner);
}

sud Judge {
    
}
