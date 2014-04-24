package OFPHello;

use strict;
use warnings;

use OFPType;
use OFPHeader;

my $header = OFPHeader->new();


sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    $self->{header}->{type} = OFPType->OFPT_HELLO;
    return $self;
}

sub encode {
    my $self = shift;
}


1;
