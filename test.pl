package test;

use strict;
use warnings;
use Time::HiRes qw(setitimer ITIMER_VIRTUAL time);

$SIG{VTALRM} = sub{print time."\n"};
setitimer(ITIMER_VIRTUAL, 10, 2.5);

while(1) {

}

