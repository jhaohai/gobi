package OFPType;

use strict;
use warnings;

use constant {
    #Symmetric message
    OFPT_HELLO                      => 0x0000,
    OFPT_ERROR                      => 0x0001,
    OFPT_ECHO_REQUEST               => 0x0002,
    OFPT_ECHO_REPLY                 => 0x0003,
    OFPT_EXPERIMENTER               => 0x0004,
    
    #Controller/switch message
    OFPT_FEATURES_REQUEST           => 0x0005,
    OFPT_FEATURES_REPLY             => 0x0006,
    OFPT_GET_CONFIG_REQUEST         => 0x0007,
    OFPT_GET_CONFIG_REPLY           => 0x0008,
    OFPT_SET_CONFIG                 => 0x0009,
    
    #Async message
    OFPT_PACKET_IN                  => 0x000a,
    OFPT_FLOW_REMOVED               => 0x000b,
    OFPT_PORT_STATUS                => 0x000c,
    
    #Controller/switch message
    OFPT_PACKET_OUT                 => 0x000d,
    OFPT_FLOW_MOD                   => 0x000e,
    OFPT_GROUP_MOD                  => 0x000f,
    OFPT_PORT_MOD                   => 0x0010,
    OFPT_TABLE_MOD                  => 0x0011,
    OFPT_MULTIPART_REQUEST          => 0x0012,
    OFPT_MULTIPART_REPLY            => 0x0013,
    OFPT_BARRIER_REQUES             => 0x0014,
    OFPT_BARRIER_REPLY              => 0x0015,
    OFPT_QUEUE_GET_CONFIG_REQUEST   => 0x0016,
    OFPT_QUEUE_GET_CONFIG_REPLY     => 0x0017,
    OFPT_ROLE_REQUEST               => 0x0018,
    OFPT_ROLE_REPLY                 => 0x0019,
    OFPT_GET_ASYNC_REQUEST          => 0x001a,
    OFPT_GET_ASYNC_REPLY            => 0x001b,
    OFPT_SET_ASYNC                  => 0x001c,
    OFPT_METER_MOD                  => 0x001d,
};

1;
