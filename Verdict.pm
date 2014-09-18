package Verdict;

use strict;
use warnings;

sub judge {
    my $self = shift;
    my $results = shift;
    my $final = {};
    $final->{priority} = 0;
    $final->{valid} = 0;
    foreach my $result (@{$results}) {
        if(($final->{priority} < $resullt->{priority}) && ($result->{valid} == 1)) {
            $final = $result;
        }
    }
    return $final;
}


1;
