package gobi2;

use strict;
use warnings;
use IO::Socket::INET;
use IO::Select;

use OpenFlow;

print "Initial OpenFlow\n";
my $of = OpenFlow->new();

print "Initial Server Socket\n";
$of->init();

print "Start OpenFlow\n";
$of->start();

