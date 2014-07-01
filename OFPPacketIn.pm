package OFPPacketIn;

use strict;
use warnings;

use OFPType;
use OFPHeader;
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
    my $len = unpack("n", substr($buf, 18, 2));
    my $full_len = int(($len + 7) / 8) * 8;
    $self->{match}->decode(substr($buf, 16, $len));
    $self->{data} = substr($buf, 16 + $full_len + 2);
    my $eth_len = $self->{header}->{length} - 24 - $full_len;
}


1;
