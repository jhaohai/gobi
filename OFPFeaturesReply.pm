package OFPFeaturesReply;

use strict;
use warnings;

use OFPType;
use OFPHeader;

my $header;
my $datapath_id;
my $n_buffers;
my $n_tables;
my $auxiliary_id;
my $capabilities;
my $reserved;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    $self->{header} = OFPHeader->new();
    return $self;
}

sub decode {
    my $self = shift;
    $self->{header} = shift;
    ($self->{datapath_id}, $self->{n_buffers}, $self->{n_tables}, $self->{auxiliary_id}, $self->{capabilities}, $self->{reserved}) = unpack("H16 N C C x2 N N", shift);
}


1;
