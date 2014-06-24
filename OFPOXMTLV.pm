package OFPOXMTLV;

use strict;
use warnings;

my $oxm_class;
my $oxm_field;
my $oxm_hasmask;
my $oxm_length;
my $oxm_payload;

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    return $self;
}

sub decode {
    my $self = shift;
    my $buf = shift;
    my $oxm_fh;
    ($self->{oxm_class}, $oxm_fh, $self->{oxm_length}) = unpack("n C C", substr($buf, 0, 4));
    $self->{oxm_field} = int($oxm_fh/2);
    $self->{oxm_hasmask} = $oxm_fh%2;
    $self->{oxm_payload} = substr($buf, 4, $self->{oxm_length});
    return substr($buf, 4 + $self->{oxm_length});
}



1;