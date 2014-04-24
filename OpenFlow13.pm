package OpenFlow13;

use strict;
use warnings;

use constant {
    OPENFLOW_OPENFLOW_H         => 1,
    
    OFP_VERSION                 => 0x04,
    
    OFP_MAX_TABLE_NAME_LEN      => 32,
    OFP_MAX_PORT_NAME_LEN       => 16,
    
    OFP_TCP_PORT                => 6653,
    OFP_SSL_PORT                => 6653,
    
    OFP_ETH_ALEN                => 6,         
};

#ofp_port_no
use constant {  
    OFPP_MAX        => 0xffffff00,
    OFPP_IN_PORT    => 0xfffffff8,
    OFPP_TABLE      => 0xfffffff9,
    OFPP_NORMAL     => 0xfffffffa,
    OFPP_FLOOD      => 0xfffffffb,
    OFPP_ALL        => 0xfffffffc,
    OFPP_CONTROLLER => 0xfffffffd,
    OFPP_LOCAL      => 0xfffffffe,
    OFPP_ANY        => 0xffffffff,
};

#ofp_type
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

struct ofp_header => {
    version => '$',
    type    => '$',
    length  => '$',
    xid     => '$',
};

use constant {
    OFP_HEADER_FMT  => "C C n N",
    OFP_HEADER_LEN  => 8,
};

#ofp_hello_elem_type
use constant {
    OFPHET_VERSIONBITMAP    => 0x0001,
};

struct ofp_hello_elem_header => {
    type    => '$',
    length  => '$',
};

use constant {
    OFP_HELLO_ELEM_HEADER_FMT   => "n n",
    OFP_HELLO_ELEM_HEADER_LEN   => 4,
};

struct ofp_hello_elem_versionbitmap => {
    type    => '$',
    length  => '$',
    bitmaps => '@',
};

use constant {
    OFP_HELLO_ELEM_VERSIONBITMAP_FMT    => "n n",
    OFP_HELLO_ELEM_VERSIONBITMAP_LEN    => 4,
};

struct ofp_hello => {
    header      => 'ofp_header',
    elements    => '@',
};

use constant {
    OFP_HELLO_FMT   => "a".OFP_HEADER_LEN,
    OFP_HELLO_LEN   => 8,
};

use constant {
    OFP_DEFAULT_MISS_SEND_LEN   => 128,
};

#ofp_config_flags
use constant {
    OFPC_FRAG_NORMAL    => 0x0000,
    OFPC_FRAG_DROP      => 0x0001,
    OFPC_FRAG_REASM     => 0x0002,
    OFPC_FRAG_MASK      => 0x0003,
};

struct ofp_switch_config => {
    header          => 'ofp_header',
    flags           => '$',
    miss_send_len   => '$',
};

use constant {
    OFP_SWITCH_CONFIG_FMT   => "n n",
    OFP_SWITCH_CONFIG_LEN   => 12,
};

#ofp_table_config
use constant {
    OFPTC_DEPRECATED_MASK   => 0x00000003,
};

#ofp_table
use constant {
    OFPTT_MAX   => 0xfe,
    OFPTT_ALL   => 0xff,
};

struct ofp_table_mod => {
    header      => 'ofp_header',
    table_id    => '$',
    config      => '$',
};

use constant {
    OFP_TABLE_MOD_FMT   => "C x3 N",
    OFP_TABLE_MOD_LEN   => 16,
};

#ofp_capabilities
use constant {
    OFPC_FLOW_STATS     => (1 << 0),
    OFPC_TABLE_STATS    => (1 << 1),
    OFPC_PORT_STATS     => (1 << 2),
    OFPC_GROUP_STATS    => (1 << 3),
    OFPC_IP_REASM       => (1 << 5),
    OFPC_QUEUE_STATS    => (1 << 6),
    OFPC_PORT_BLOCKED   => (1 << 8),
};

#ofp_port_config
use constant {
    OFPPC_PORT_DOWN     => (1 << 0),
    OFPPC_NO_RECV       => (1 << 2),
    OFPPC_NO_FWD        => (1 << 5),
    OFPPC_NO_PACKET_IN  => (1 << 6),
};

#ofp_port_state
use constant {
    OFPPS_LINK_DOWN => (1 << 0),
    OFPPS_BLOCKED   => (1 << 1),
    OFPPS_LIVE      => (1 << 2),
};

#ofp_port_features
use constant {
    OFPPF_10MB_HD       => (1 << 0),
    OFPPF_10MB_FD       => (1 << 1),
    OFPPF_100MB_HD      => (1 << 2),
    OFPPF_100MB_FD      => (1 << 3),
    OFPPF_1GB_HD        => (1 << 4),
    OFPPF_1GB_FD        => (1 << 5),
    OFPPF_10GB_FD       => (1 << 6),
    OFPPF_40GB_FD       => (1 << 7),
    OFPPF_100GB_FD      => (1 << 8),
    OFPPF_1TB_FD        => (1 << 9),
    OFPPF_OTHER         => (1 << 10),
    OFPPF_COPPER        => (1 << 11),
    OFPPF_FIBER         => (1 << 12),
    OFPPF_AUTONEG       => (1 << 13),
    OFPPF_PAUSE         => (1 << 14),
    OFPPF_PAUSE_ASYM    => (1 << 15),
};

struct ofp_port => {
    port_no     => '$',
    hw_addr     => '@',
    name        => '@',
    config      => '$',
    state       => '$',
    curr        => '$',
    advertised  => '$',
    supported   => '$',
    peer        => '$',
    curr_speed  => '$',
    max_speed   => '$',
};

use constant {
    OFP_PORT_FMT    => "N x4 H12 x2 A16 N N N N N N N N",
    OFP_PORT_LEN    => 64,
};

struct ofp_switch_features => {
    header          => 'ofp_header',
    datapath_id     => '$',
    n_buffers       => '$',
    n_tables        => '$',
    auxiliary_id    => '$',
    capabilities    => '$',
    reserved        => '$',
};

use constant {
    OFP_SWITCH_FEATURES_FMT => "H16 N C C x2 N N",
    OFP_SWITCH_FEATURES_LEN => 32,
};

#ofp_port_reason
use constant {
    OFPPR_ADD       => 0x00,
    OFPPR_DELETE    => 0x01,
    OFPPR_MODIFY    => 0x02,
};

struct ofp_port_status => {
    header  => 'ofp_header',
    reason  => '$',
    desc    => 'ofp_port',
};

use constant {
    OFP_PORT_STATUS_FMT => "C x7 a".OFP_PORT_LEN,
    OFP_PORT_STATUS_LEN => 80,
};

struct ofp_port_mod => {
    header      => 'ofp_header',
    port_no     => '$',
    hw_addr     => '@',
    config      => '$',
    mask        => '$',
    advertise   => '$',
};

use constant {
    OFP_PORT_MOD_FMT    => "N x4 H12 x2 N N N x4",
    OFP_PORT_MOD_LEN    => 40,
};

#ofp_match_type
use constant {
    OFPMT_STANDARD  => 0x0000,
    OFPMT_OXM       => 0x0001,
};

struct ofp_oxm => {
    oxm_class   => '$',
    oxm_field   => '$',
    oxm_hasmask => '$',
    oxm_length  => '$',
    oxm_value   => '$',
};

use constant {
    OFP_OXM_FMT => "n C C",
    OFP_OXM_LEN => 4,
};

struct ofp_match => {
    type        => '$',
    length      => '$',
    oxm_fields  => '$',
};

use constant {
    OFP_MATCH_FMT   => "n n",
    OFP_MATCH_LEN   => 8,
};

#ofp_oxm_class
use constant {
    OFPXMC_NXM_0            => 0x0000,
    OFPXMC_NXM_1            => 0x0001,
    OFPXMC_OPENFLOW_BASIC   => 0x8000,
    OFPXMC_EXPERIMENTER     => 0xffff,
};

#oxm_ofb_match_fields
use constant {
    OFPXMT_OFB_IN_PORT          => 0x00,
    OFPXMT_OFB_IN_PHY_PORT      => 0x01,
    OFPXMT_OFB_METADATA         => 0x02,
    OFPXMT_OFB_ETH_DST          => 0x03,
    OFPXMT_OFB_ETH_SRC          => 0x04,
    OFPXMT_OFB_ETH_TYPE         => 0x05,
    OFPXMT_OFB_VLAN_VID         => 0x06,
    OFPXMT_OFB_VLAN_PCP         => 0x07,
    OFPXMT_OFB_IP_DSCP          => 0x08,
    OFPXMT_OFB_IP_ECN           => 0x09,
    OFPXMT_OFB_IP_PROTO         => 0x0a,
    OFPXMT_OFB_IPV4_SRC         => 0x0b,
    OFPXMT_OFB_IPV4_DST         => 0x0c,
    OFPXMT_OFB_TCP_SRC          => 0x0d,
    OFPXMT_OFB_TCP_DST          => 0x0e,
    OFPXMT_OFB_UDP_SRC          => 0x0f,
    OFPXMT_OFB_UDP_DST          => 0x10,
    OFPXMT_OFB_SCTP_SRC         => 0x11,
    OFPXMT_OFB_SCTP_DST         => 0x12,
    OFPXMT_OFB_ICMPV4_TYPE      => 0x13,
    OFPXMT_OFB_ICMPV4_CODE      => 0x14,
    OFPXMT_OFB_ARP_OP           => 0x15,
    OFPXMT_OFB_ARP_SPA          => 0x16,
    OFPXMT_OFB_ARP_TPA          => 0x17,
    OFPXMT_OFB_ARP_SHA          => 0x18,
    OFPXMT_OFB_ARP_THA          => 0x19,
    OFPXMT_OFB_IPV6_SRC         => 0x1a,
    OFPXMT_OFB_IPV6_DST         => 0x1b,
    OFPXMT_OFB_IPV6_FLABEL      => 0x1c,
    OFPXMT_OFB_ICMPV6_TYPE      => 0x1d,
    OFPXMT_OFB_ICMPV6_CODE      => 0x1e,
    OFPXMT_OFB_IPV6_ND_TARGET   => 0x1f,
    OFPXMT_OFB_IPV6_ND_SLL      => 0x20,
    OFPXMT_OFB_IPV6_ND_TLL      => 0x21,
    OFPXMT_OFB_MPLS_LABEL       => 0x22,
    OFPXMT_OFB_MPLS_TC          => 0x23,
    OFPXMT_OFB_MPLS_BOS         => 0x24,
    OFPXMT_OFB_PBB_ISID         => 0x25,
    OFPXMT_OFB_TUNNEL_ID        => 0x26,
    OFPXMT_OFB_IPV6_EXTHDR      => 0x27,
    OFPXMT_OFB_ALL              => ((1 << 40) -1),
};

#ofp_vlan_id
use constant {
    OFPVID_PRESENT  => 0x1000,
    OFPVID_NONE     => 0x0000,
};

use constant {
    OFP_VLAN_NONE   => OFPVID_NONE,
};

#ofp_ipv6exthdr_flags
use constant {
    OFPIEH_NONEXT   => (1 << 0),
    OFPIEH_ESP      => (1 << 1),
    OFPIEH_AUTH     => (1 << 2),
    OFPIEH_DEST     => (1 << 3),
    OFPIEH_FRAG     => (1 << 4),
    OFPIEH_ROUTER   => (1 << 5),
    OFPIEH_HOP      => (1 << 6),
    OFPIEH_UNREP    => (1 << 7),
    OFPIEH_UNSEQ    => (1 << 8),
};

struct ofp_oxm_experimenter_header => {
    oxm_header      => '$',
    experimenter    => '$',
};

use constant {
    OFP_OXM_EXPERIMENTER_HEADER_FMT => "N N",
    OFP_OXM_EXPERIMENTER_HEADER_LEN => 8,
};

#ofp_action_type
use constant {
    OFPAT_OUTPUT        => 0x0000,
    OFPAT_COPY_TTL_OUT  => 0x000b,
    OFPAT_COPY_TTL_IN   => 0x000c,
    OFPAT_SET_MPLS_TTL  => 0x000f,
    OFPAT_DEC_MPLS_TTL  => 0x0010,
    OFPAT_PUSH_VLAN     => 0x0011,
    OFPAT_POP_VLAN      => 0x0012,
    OFPAT_PUSH_MPLS     => 0x0013,
    OFPAT_POP_MPLS      => 0x0014,
    OFPAT_SET_QUEUE     => 0x0015,
    OFPAT_GROUP         => 0x0016,
    OFPAT_SET_NW_TTL    => 0x0017,
    OFPAT_DEC_NW_TTL    => 0x0018,
    OFPAT_SET_FIELD     => 0x0019,
    OFPAT_PUSH_PBB      => 0x001a,
    OFPAT_POP_PBB       => 0x001b,
    OFPAT_EXPERIMENTER  => 0xffff,
};

struct ofp_action_header => {
    type    => '$',
    len     => '$',
};

use constant {
    OFP_ACTION_HEADER_FMT   => "n n x4",
    OFP_ACTION_HEADER_LEN   => 8,
};

#ofp_controller_max_len
use constant {
    OFPCML_MAX          => 0xffe5,
    OFPCML_NO_BUFFER    => 0xffff,
};

struct ofp_action_output => {
    type    => '$',
    len     => '$',
    port    => '$',
    max_len => '$',
};

use constant {
    OFP_ACTION_OUTPUT_FMT   => "n n N n x6",
    OFP_ACTION_OUTPUT_LEN   => 16,
};

struct ofp_action_mpls_ttl => {
    type        => '$',
    len         => '$',
    mpls_ttl    => '$',
};

use constant {
    OFP_ACTION_MPLS_TTL_FMT => "n n C x3",
    OFP_ACTION_MPLS_TTL_LEN => 8,
};

struct ofp_action_push => {
    type        => '$',
    len         => '$',
    ethertype   => '$',
};

use constant {
    OFP_ACTION_PUSH_FMT => "n n n x2",
    OFP_ACTION_PUSH_LEN => 8,
};

struct ofp_action_group => {
    type        => '$',
    len         => '$',
    group_id    => '$',
};

use constant {
    OFP_ACTION_GROUP_FMT    => "n n N",
    OFP_ACTION_GROUP_LEN    => 8,
};

struct ofp_action_nw_ttl => {
    type    => '$',
    len     => '$',
    nw_ttl  => '$',
};

use constant {
    OFP_ACTION_NW_TTL_FMT   => "n n C x3",
    OFP_ACTION_NW_TTL_LEN   => 8,
};

struct ofp_action_set_field => {
    type    => '$',
    len     => '$',
    field   => '@',
};

use constant {
    OFP_ACTION_SET_FIELD_FMT    => "n n H8",
    OFP_ACTION_SET_FIELD_LEN    => 8,
};

struct ofp_action_experimenter_header => {
    type            => '$',
    len             => '$',
    experimenter    => '$',
};

use constant {
    OFP_ACTION_EXPERIMENTER_HEADER_FMT  => "n n N",
    OFP_ACTION_EXPERIMENTER_HEADER_LEN  => 8,
};

#ofp_instruction_type
use constant {
    OFPIT_GOTO_TABLE        => 0x0001,
    OFPIT_WRITE_METADATA    => 0x0002,
    OFPIT_WRITE_ACTIONS     => 0x0003,
    OFPIT_APPLY_ACTIONS     => 0x0004,
    OFPIT_CLEAR_ACTIONS     => 0x0005,
    OFPIT_METER             => 0x0006,
    OFPIT_EXPERIMENTER      => 0xffff,
};

struct ofp_instruction => {
    type    => '$',
    len     => '$',
};

use constant {
    OFP_INSTRUCTION_FMT => "n n",
    OFP_INSTRUCTION_LEN => 4,
};

struct ofp_instruction_goto_table => {
    type        => '$',
    len         => '$',
    table_id    => '$',
};

use constant {
    OFP_INSTRUCTION_GOTO_TABLE_FMT  => "n n C x3",
    OFP_INSTRUCTION_GOTO_TABLE_LEN  => 8,
};

struct ofp_instruction_write_metadata => {
    type            => '$',
    len             => '$',
    metadata        => '$',
    metadata_mask   => '$',
};

use constant {
    OFP_INSTRUCTION_WRITE_METADATA_FMT  => "n n x4 H16 H16",
    OFP_INSTRUCTION_WRITE_METADATA_LEN  => 24,
};

struct ofp_instruction_actions => {
    type    => '$',
    len     => '$',
};

use constant {
    OFP_INSTRUCTION_ACTIONS_FMT => "n n x4",
    OFP_INSTRUCTION_ACTIONS_LEN => 8,
};

struct ofp_instruction_meter => {
    type        => '$',
    len         => '$',
    meter_id    => '$',
};

use constant {
    OFP_INSTRUCTION_METER_FMT   => "n n N",
    OFP_INSTRUCTION_METER_LEN   => 8,
};

struct ofp_instruction_experimenter => {
    type            => '$',
    len             => '$',
    experimenter    => '$',
};

use constant {
    OFP_INSTRUCTION_EXPERIMENTER_FMT    => "n n N",
    OFP_INSTRUCTION_EXPERIMENTER_LEN    => 8,
};

#ofp_flow_mod_command
use constant {
    OFPFC_ADD           => 0x00,
    OFPFC_MODIFY        => 0x01,
    OFPFC_MODIFY_STRICT => 0x02,
    OFPFC_DELETE        => 0x03,
    OFPFC_DELETE_STRICT => 0x04,
};

use constant {
    OFP_FLOW_PERMANENT      => 0,
    OFP_DEFAULT_PRIORITY    => 0x8000,
};

#ofp_flow_mod_flags
use constant {
    OFPFF_SEND_FLOW_REM => (1 << 0),
    OFPFF_CHECK_OVERLAP => (1 << 1),
    OFPFF_RESET_COUNTS  => (1 << 2),
    OFPFF_NO_PKT_COUNTS => (1 << 3),
    OFPFF_NO_BYT_COUNTS => (1 << 4),
};

struct ofp_flow_mod => {
    header          => 'ofp_header',
    cookie          => '$',
    cookie_mask     => '$',
    table_id        => '$',
    command         => '$',
    idle_timeout    => '$',
    hard_timeout    => '$',
    priority        => '$',
    buffer_id       => '$',
    out_port        => '$',
    out_group       => '$',
    flags           => '$',
};

use constant {
    OFP_FLOW_MOD_FMT    => "H16 H16 C C n n n N N N n x2",
    OFP_FLOW_MOD_LEN    => 56,
};

#ofp_group
use constant {
    OFPG_MAX    => 0xffffff00,
    OFPG_ALL    => 0xfffffffc,
    OFPG_ANY    => 0xffffffff,
};

#ofp_group_mod_command
use constant {
    OFPGC_ADD       => 0x0000,
    OFPGC_MODIFY    => 0x0001,
    OFPGC_DELETE    => 0x0002,
};

struct ofp_bucket => {
    len         => '$',
    weight      => '$',
    watch_port  => '$',
    watch_group => '$',
};

use constant {
    OFP_BUCKET_FMT  => "n n N N x4",
    OFP_BUCKET_LEN  => 16,
};

struct ofp_group_mod => {
    header      => 'ofp_header',
    command     => '$',
    type        => '$',
    group_id    => '$',
};

use constant {
    OFP_GROUP_MOD_FMT   => "n C C N",
    OFP_GROUP_MOD_LEN   => 16,
};



#ofp_group_type
use constant {
    OFPGT_ALL       => 0x00,
    OFPGT_SELECT    => 0x01,
    OFPGT_INDIRECT  => 0x02,
    OFPGT_FF        => 0x03,
};

use constant {
    OFP_NO_BUFFER   => 0xffffffff,
};

struct ofp_packet_out => {
    header      => 'ofp_header',
    buffer_id   => '$',
    in_port     => '$',
    actions_len => '$',
};

use constant {
    OFP_PACKET_OUT_FMT  => "N N n x6",
    OFP_PACKET_OUT_LEN  => 24,
};

#ofp_packet_in_reason
use constant {
    OFPR_NO_MATCH       => 0x00,
    OFPR_ACTION         => 0x01,
    OFPR_INVALID_TTL    => 0x02,
};

struct ofp_packet_in => {
    header      => 'ofp_header',
    buffer_id   => '$',
    total_len   => '$',
    reason      => '$',
    table_id    => '$',
    cookie      => '$',
    match       => 'ofp_match',
};

use constant {
    OFP_PACKET_IN_FMT   => "N n C C H16",
    OFP_PACKET_IN_LEN   => 32,
};

#ofp_flow_removed_reason
use constant {
    OFPRR_IDLE_TIMEOUT  => 0x00,
    OFPRR_HARD_TIMEOUT  => 0x01,
    OFPRR_DELETE        => 0x02,
    OFPRR_GROUP_DELETE  => 0x03,
};

struct ofp_flow_removed => {
    header          => 'ofp_header',
    cookie          => '$',
    priority        => '$',
    reason          => '$',
    table_id        => '$',
    duration_sec    => '$',
    duration_nsec   => '$',
    idle_timeout    => '$',
    hard_timeout    => '$',
    packet_count    => '$',
    byte_count      => '$',
    match           => 'ofp_match',
};

use constant {
    OFP_FLOW_REMOVED_FMT    => "H16 n C C N N n n H16 H16",
    OFP_FLOW_REMOVED_LEN    => 56,
};

#ofp_meter
use constant {
    OFPM_MAX        => 0xffff0000,
    OFPM_SLOWPATH   => 0xfffffffd,
    OFPM_CONTROLLER => 0xfffffffe,
    OFPM_ALL        => 0xffffffff,
};

#ofp_meter_band_type
use constant {
    OFPMBT_DROP         => 0x0001,
    OFPMBT_DSCP_REMARK  => 0x0002,
    OFPMBT_EXPERIMENTER => 0xffff,
};

struct ofp_meter_band_header => {
    type        => '$',
    len         => '$',
    rate        => '$',
    burst_size  => '$',
};

use constant {
    OFP_METER_BAND_HEADER_FMT   => "n n N N",
    OFP_METER_BAND_HEADER_LEN   => 12,
};

struct ofp_meter_band_drop => {
    type        => '$',
    len         => '$',
    rate        => '$',
    burst_size  => '$',
};

use constant {
    OFP_METER_BAND_DROP_FMT   => "n n N N x4",
    OFP_METER_BAND_DROP_LEN   => 16,
};

struct ofp_meter_band_dscp_remark => {
    type        => '$',
    len         => '$',
    rate        => '$',
    burst_size  => '$',
    prec_level  => '$',
};

use constant {
    OFP_METER_BAND_DSCP_REMARK_FMT  => "n n N N C x3",
    OFP_METER_BAND_DSCP_REMARK_LEN  => 16,
};

#ofp_meter_mod_command
use constant {
    OFPMC_ADD       => 0x0000,
    OFPMC_MODIFY    => 0x0001,
    OFPMC_DELETE    => 0x0002,
};

#ofp_meter_flags
use constant {
    OFPMF_KBPS  => (1 << 0),
    OFPMF_PKTPS => (1 << 1),
    OFPMF_BURST => (1 << 2),
    OFPMF_STATS => (1 << 3),
};

#ofp_error_type
use constant {
    OFPET_HELLO_FAILED          => 0x0000,
    OFPET_BAD_REQUEST           => 0x0001,
    OFPET_BAD_ACTION            => 0x0002,
    OFPET_BAD_INSTRUCTION       => 0x0003,
    OFPET_BAD_MATCH             => 0x0004,
    OFPET_FLOW_MOD_FAILED       => 0x0005,
    OFPET_GROUP_MOD_FAILED      => 0x0006,
    OFPET_PORT_MOD_FAILED       => 0x0007,
    OFPET_TABLE_MOD_FAILED      => 0x0008,
    OFPET_QUEUE_OP_FAILED       => 0x0009,
    OFPET_SWITCH_CONFIG_FAILED  => 0x000a,
    OFPET_ROLE_REQUEST_FAILED   => 0x000b,
    OFPET_METER_MOD_FAILED      => 0x000c,
    OFPET_TABLE_FEATURES_FAILED => 0x000d,
    OFPET_EXPERIMENTER          => 0xffff,
};

#ofp_hello_failed_code
use constant {
    OFPHFC_INCOMPATIBLE => 0x0000,
    OFPHFC_EPERM        => 0x0001,
};

#ofp_bad_request_code
use constant {
    OFPBRC_BAD_VERSION                  => 0x0000,
    OFPBRC_BAD_TYPE                     => 0x0001,
    OFPBRC_BAD_MULTIPART                => 0x0002,
    OFPBRC_BAD_EXPERIMENTER             => 0x0003,
    OFPBRC_BAD_EXP_TYPE                 => 0x0004,
    OFPBRC_EPERM                        => 0x0005,
    OFPBRC_BAD_LEN                      => 0x0006,
    OFPBRC_BUFFER_EMPTY                 => 0x0007,
    OFPBRC_BUFFER_UNKNOWN               => 0x0008,
    OFPBRC_BAD_TABLE_ID                 => 0x0009,
    OFPBRC_IS_SLAVE                     => 0x000a,
    OFPBRC_BAD_PORT                     => 0x000b,
    OFPBRC_BAD_PACKET                   => 0x000c,
    OFPBRC_MULTIPART_BUFFER_OVERFLOW    => 0x000d,
};

#ofp_bad_action_code
use constant {
    OFPBAC_BAD_TYPE             => 0x0000,
    OFPBAC_BAD_LEN              => 0x0001,
    OFPBAC_BAD_EXPERIMENTER     => 0x0002,
    OFPBAC_BAD_EXP_TYPE         => 0x0003,
    OFPBAC_BAD_OUT_PORT         => 0x0004,
    OFPBAC_BAD_ARGUMENT         => 0x0005,
    OFPBAC_EPERM                => 0x0006,
    OFPBAC_TOO_MANY             => 0x0007,
    OFPBAC_BAD_QUEUE            => 0x0008,
    OFPBAC_BAD_OUT_GROUP        => 0x0009, 
    OFPBAC_MATCH_INCONSISTENT   => 0x000a,
    OFPBAC_UNSUPPORTED_ORDER    => 0x000b,
    OFPBAC_BAD_TAG              => 0x000c,
    OFPBAC_BAD_SET_TYPE         => 0x000d,
    OFPBAC_BAD_SET_LEN          => 0x000e,
    OFPBAC_BAD_SET_ARGUMENT     => 0x000f,
};

#ofp_bad_instruction_code
use constant {
    OFPBIC_UNKNOWN_INST         => 0x0000,
    OFPBIC_UNSUP_INST           => 0x0001,
    OFPBIC_BAD_TABLE_ID         => 0x0002,
    OFPBIC_UNSUP_METADATA       => 0x0003,
    OFPBIC_UNSUP_METADATA_MASK  => 0x0004,
    OFPBIC_BAD_EXPERIMENTER     => 0x0005,
    OFPBIC_BAD_EXP_TYPE         => 0x0006,
    OFPBIC_BAD_LEN              => 0x0007,
    OFPBIC_EPERM                => 0x0008,
};

#ofp_bad_match_code
use constant {
    OFPBMC_BAD_TYPE         => 0x0000,
    OFPBMC_BAD_LEN          => 0x0001,
    OFPBMC_BAD_TAG          => 0x0002,
    OFPBMC_BAD_DL_ADDR_MASK => 0x0003,
    OFPBMC_BAD_NW_ADDR_MASK => 0x0004,
    OFPBMC_BAD_WILDCARDS    => 0x0005,
    OFPBMC_BAD_FIELD        => 0x0006,
    OFPBMC_BAD_VALUE        => 0x0007,
    OFPBMC_BAD_MASK         => 0x0008,
    OFPBMC_BAD_PREREQ       => 0x0009,
    OFPBMC_DUP_FIELD        => 0x000a,
    OFPBMC_EPERM            => 0x000b,
};

#ofp_flow_mod_failed_code
use constant {
    OFPFMFC_UNKNOWN         => 0x0000,
    OFPFMFC_TABLE_FULL      => 0x0001,
    OFPFMFC_BAD_TABLE_ID    => 0x0002,
    OFPFMFC_OVERLAP         => 0x0003,
    OFPFMFC_EPERM           => 0x0004,
    OFPFMFC_BAD_TIMEOUT     => 0x0005,
    OFPFMFC_BAD_COMMAND     => 0x0006,
    OFPFMFC_BAD_FLAGS       => 0x0007,
};

#ofp_group_mod_failed_code
use constant {
    OFPGMFC_GROUP_EXISTS            => 0x0000,
    OFPGMFC_INVALID_GROUP           => 0x0001,
    OFPGMFC_WEIGHT_UNSUPPORTED      => 0x0002,
    OFPGMFC_OUT_OF_GROUPS           => 0x0003,
    OFPGMFC_OUT_OF_BUCKETS          => 0x0004,
    OFPGMFC_CHAINING_UNSUPPORTED    => 0x0005, 
    OFPGMFC_WATCH_UNSUPPORTED       => 0x0006,
    OFPGMFC_LOOP                    => 0x0007,
    OFPGMFC_UNKNOWN_GROUP           => 0x0008,
    OFPGMFC_CHAINED_GROUP           => 0x0009,
    OFPGMFC_BAD_TYPE                => 0x000a,
    OFPGMFC_BAD_COMMAND             => 0x000b,
    OFPGMFC_BAD_BUCKET              => 0x000c,
    OFPGMFC_BAD_WATCH               => 0x000d,
    OFPGMFC_EPERM                   => 0x000e,
};

#ofp_port_mod_failed_code
use constant {
    OFPPMFC_BAD_PORT        => 0x0000,
    OFPPMFC_BAD_HW_ADDR     => 0x0001,
    OFPPMFC_BAD_CONFIG      => 0x0002,
    OFPPMFC_BAD_ADVERTISE   => 0x0003,
    OFPPMFC_EPERM           => 0x0004,
};

#ofp_table_mod_failed_code
use constant {
    OFPTMFC_BAD_TABLE   => 0x0000,
    OFPTMFC_BAD_CONFIG  => 0x0001,
    OFPTMFC_EPERM       => 0x0002,
};

#ofp_queue_op_failed_code
use constant {
    OFPQOFC_BAD_PORT    => 0x0000,
    OFPQOFC_BAD_QUEUE   => 0x0001,
    OFPQOFC_EPERM       => 0x0002,
};

#ofp_switch_config_failed_code
use constant {
    OFPSCFC_BAD_FLAGS   => 0x0000,
    OFPSCFC_BAD_LEN     => 0x0001,
    OFPSCFC_EPERM       => 0x0002,
};

#ofp_role_request_failed_code
use constant {
    OFPRRFC_STALE       => 0x0000,
    OFPRRFC_UNSUP       => 0x0001,
    OFPRRFC_BAD_ROLE    => 0x0002,
};

#ofp_meter_mod_failed_code
use constant {
    OFPMMFC_UNKNOWN         => 0x0000,
    OFPMMFC_METER_EXISTS    => 0x0001,
    OFPMMFC_INVALID_METER   => 0x0002,
    OFPMMFC_UNKNOWN_METER   => 0x0003,
    OFPMMFC_BAD_COMMAND     => 0x0004,
    OFPMMFC_BAD_FLAGS       => 0x0005,
    OFPMMFC_BAD_RATE        => 0x0006,
    OFPMMFC_BAD_BURST       => 0x0007,
    OFPMMFC_BAD_BAND        => 0x0008,
    OFPMMFC_BAD_BAND_VALUE  => 0x0009,
    OFPMMFC_OUT_OF_METERS   => 0x000a,
    OFPMMFC_OUT_OF_BANDS    => 0x000b,
};

#ofp_table_features_failed_code
use constant {
    OFPTFFC_BAD_TABLE       => 0x0000,
    OFPTFFC_BAD_METADATA    => 0x0001,
    OFPTFFC_BAD_TYPE        => 0x0002,
    OFPTFFC_BAD_LEN         => 0x0003,
    OFPTFFC_BAD_ARGUMENT    => 0x0004,
    OFPTFFC_EPERM           => 0x0005,
};

#ofp_multipart_type
use constant {
    OFPMP_DESC              => 0x0000,
    OFPMP_FLOW              => 0x0001,
    OFPMP_AGGREGATE         => 0x0002,
    OFPMP_TABLE             => 0x0003,
    OFPMP_PORT_STATS        => 0x0004,
    OFPMP_QUEUE             => 0x0005,
    OFPMP_GROUP             => 0x0006,
    OFPMP_GROUP_DESC        => 0x0007,
    OFPMP_GROUP_FEATURES    => 0x0008,
    OFPMP_METER             => 0x0009,
    OFPMP_METER_CONFIG      => 0x000a,
    OFPMP_METER_FEATURES    => 0x000b,
    OFPMP_TABLE_FEATURES    => 0x000c,
    OFPMP_PORT_DESC         => 0x000d,
    OFPMP_EXPERIMENTER      => 0xffff,
};

#ofp_multipart_request_flags
use constant {
    OFPMPF_REQ_MORE => (1 << 0),
};

#ofp_multipart_reply_flags
use constant {
    OFPMPF_REPLY_MORE   => (1 << 0),
};

use constant {
    DESC_STR_LEN    => 256,
    SERIAL_NUM_LEN  => 32,
};

#ofp_table_feature_prop_type
use constant {
    OFPTFPT_INSTRUCTIONS        => 0x0000,
    OFPTFPT_INSTRUCTIONS_MISS   => 0x0001,
    OFPTFPT_NEXT_TABLES         => 0x0002,
    OFPTFPT_NEXT_TABLES_MISS    => 0x0003,
    OFPTFPT_WRITE_ACTIONS       => 0x0004,
    OFPTFPT_WRITE_ACTIONS_MISS  => 0x0005,
    OFPTFPT_APPLY_ACTIONS       => 0x0006,
    OFPTFPT_APPLY_ACTIONS_MISS  => 0x0007,
    OFPTFPT_MATCH               => 0x0008,
    OFPTFPT_WILDCARDS           => 0x000a,
    OFPTFPT_WRITE_SETFIELD      => 0x000c,
    OFPTFPT_WRITE_SETFIELD_MISS => 0x000d,
    OFPTFPT_APPLY_SETFIELD      => 0x000e,
    OFPTFPT_APPLY_SETFIELD_MISS => 0x000f,
    OFPTFPT_EXPERIMENTER        => 0xfffe,
    OFPTFPT_EXPERIMENTER_MISS   => 0xffff,
};

#ofp_group_capabilities
use constant {
    OFPGFC_SELECT_WEIGHT    => (1 << 0),
    OFPGFC_SELECT_LIVENESS  => (1 << 1),
    OFPGFC_CHAINING         => (1 << 2),
    OFPGFC_CHAINING_CHECKS  => (1 << 3),
};

use constant {
    OFPQ_ALL            => 0xffffffff,
    OFPQ_MIN_RATE_UNCFG => 0xffff,
    OFPQ_MAX_RATE_UNCFG => 0xffff,
};

#ofp_queue_properties
use constant {
    OFPQT_MIN_RATE      => 0x0001,
    OFPQT_MAX_RATE      => 0x0002,
    OFPQT_EXPERIMENTER  => 0xffff,
};

#ofp_controller_role
use constant {
    OFPCR_ROLE_NOCHANGE => 0x0000,
    OFPCR_ROLE_EQUAL    => 0x0001,
    OFPCR_ROLE_MASTER   => 0x0002,
    OFPCR_ROLE_SLAVE    => 0x0003,
};

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    return $self;
}

sub ofp_header_decode {
    my $self = shift;
    my $ofp_header = ofp_header->new();
    my($version, $type, $length, $xid) = unpack(OFP_HEADER_FMT, shift);
    $ofp_header->version($version);
    $ofp_header->type($type);
    $ofp_header->length($length);
    $ofp_header->xid($xid);
    return $ofp_header;
}

sub ofp_hello_elem_header_decode {
    my $self = shift;
    my $ofp_hello_elem_header = ofp_hello_elem_header->new();
    my($type, $length) = unpack(OFP_HELLO_ELEM_HEADER_FMT, shift);
    $ofp_hello_elem_header->type($type);
    $ofp_hello_elem_header->length($length);
    return $ofp_hello_elem_header;
}

sub ofp_switch_features_decode {
    my $self = shift;
    my $header = shift;
    my $ofp_switch_features = ofp_switch_features->new();
    my($datapath_id, $n_buffers, $n_tables, $auxiliary_id, $capabilities, $reserved) = unpack(OFP_SWITCH_FEATURES_FMT, shift);
    $ofp_switch_features->header($header);
    $ofp_switch_features->datapath_id($datapath_id);
    $ofp_switch_features->n_buffers($n_buffers);
    $ofp_switch_features->n_tables($n_tables);
    $ofp_switch_features->auxiliary_id($auxiliary_id);
    $ofp_switch_features->capabilities($capabilities);
    $ofp_switch_features->reserved($reserved);
    return $ofp_switch_features;
}

sub ofp_oxm_fields_decode {
    my $self = shift;
    my $oxm_fields = shift;
    my @oxms;
    while(length($oxm_fields)) {
        my $oxm = ofp_oxm->new();
        my($oxm_class, $oxm_field_hasmask, $oxm_length) = unpack(OFP_OXM_FMT, substr($oxm_fields, 0, OFP_OXM_LEN));
        my $oxm_field = int($oxm_field_hasmask/2);
        my $oxm_hasmask = $oxm_field_hasmask%2;
        $oxm->oxm_class($oxm_class);
        $oxm->oxm_field($oxm_field);
        $oxm->oxm_hasmask($oxm_hasmask);
        $oxm->oxm_length($oxm_length);
        $oxm->oxm_value(substr($oxm_fields, OFP_OXM_LEN, $oxm_length));
        push(@oxms, $oxm);
        $oxm_fields = substr($oxm_fields, OFP_OXM_LEN+$oxm_length);
    }
    return @oxms;
}

sub ofp_match_decode {
    my $self = shift;
    my $ofp_match = ofp_match->new();
    my($type, $length, $oxm_fields) = unpack(OFP_MATCH_FMT."a*", shift);
    $ofp_match->type($type);
    $ofp_match->length($length);
    $ofp_match->oxm_fields(substr($oxm_fields, 0, $length-4));
    return $ofp_match;
}

sub ofp_packet_in_decode {
    my $self = shift;
    my $header = shift;
    my $ofp_packet_in = ofp_packet_in->new();
    my($buffer_id, $total_len, $reason, $table_id, $cookie, $match) = unpack(OFP_PACKET_IN_FMT."a*", shift);
    $ofp_packet_in->header($header);
    $ofp_packet_in->buffer_id($buffer_id);
    $ofp_packet_in->total_len($total_len);
    $ofp_packet_in->reason($reason);
    $ofp_packet_in->table_id($table_id);
    $ofp_packet_in->cookie($cookie);
    $ofp_packet_in->match($self->ofp_match_decode($match));
    return $ofp_packet_in;
}

sub ofp_hello_encode {
    my $self = shift;
    my $ofp_header = pack(OFP_HEADER_FMT, OFP_VERSION, OFPT_HELLO, OFP_HEADER_LEN, 0,);
    return $ofp_header;
}

sub ofp_features_request_encode {
    my $self = shift;
    my $ofp_header = pack(OFP_HEADER_FMT, OFP_VERSION, OFPT_FEATURES_REQUEST, OFP_HEADER_LEN, 0);
    return $ofp_header;
}

sub ofp_echo_reply_encode {
    my $self = shift;
    my $ofp_header = pack(OFP_HEADER_FMT, OFP_VERSION, OFPT_ECHO_REPLY, OFP_HEADER_LEN, 0);
    return $ofp_header;
}

sub ofp_packet_out_encode {
    
}




1;
