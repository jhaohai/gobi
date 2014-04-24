package OFPPacketIn;

use strict;
use warnings;

use OFType;
use OFHeader;
use OFPMatch;

my $header;
my $buffer_id;
my $total_len;
my $reason;
my $table_id;
my $cookie;
my $match;
my $data;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    $self->{header} = OFPHeader->new();
    $self->{match} = OFPMatch->new();
    return $self;
}

sub decode {
    my $self = shift;
    $self->{header} = shift;
    my $buf = shift;
    ($self->{buffer_id}, $self->{total_len}, $self->{reason}, $self->{table_id}, $self->{cookie}) = unpack("N n C C H16", substr($buf, 0, 16));
    $buf = $self->{match}->decode(substr($buf, 16));
    
}


1;
