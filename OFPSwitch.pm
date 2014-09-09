package OFPSwitch;

use strict;
use warnings;

my $sock;
my $dpid;
my $buffers;
my $tables;
my $auxid;
my $capab;
my $resrv;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    $self->{dpid} = "0000000000000000";
    return $self;
}

sub set {
    my $self = shift;
    my $features = shift;
    $self->{dpid} = $features->{datapath_id};
    $self->{buffers} = $features->{n_buffers};
    $self->{tables} = $features->{n_tables};
    $self->{auxid} = $features->{auxiliary_id};
    $self->{capab} = $features->{capabilities};
    $self->{resrv} = $features->{reserved};
}

sub sendto {
    my $self = shift;
    my $buf = shift;
    $self->{sock}->send($buf);
}


1;
