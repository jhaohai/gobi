package OFPHeader;

use strict;
use warnings;

my $version;
my $type;
my $length;
my $xid;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    return $self;
}



1;
