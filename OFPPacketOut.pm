package OFPPacketOut;

use strict;
use warnings;

use OFPHeader;

my $header = OFPHeader->new();
my $buffer_id;
my $in_port;
my $actions_len;
my @actions;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    return $self;
}

sub get_header {
    return $header;
}

sub set_header {
    $header = shift;
}

sub get_buffer_id {
    return $buffer_id;
}

sub set_buffer_id {
    $buffer_id = shift;
}

sub get_in_port {
    return $in_port;
}

sub set_in_port {
    $in_port = shift;
}
