package protocol10;

use strict;
use warnings;
use Class::Struct;

use constant {
    OPENFLOW_OPENFLOW_H         => 1,
    
    OFP_VERSION                 => 0x01,
    
    OFP_MAX_TABLE_NAME_LEN      => 32,
    OFP_MAX_PORT_NAME_LEN       => 16,
    
    OFP_TCP_PORT                => 6653,
    OFP_SSL_PORT                => 6653,
    
    OFP_ETH_ALEN                => 6,           
};

#ofp_port
use constant {   
    OFPP_MAX        => 0xff00,
    OFPP_IN_PORT    => 0xfff8,
    OFPP_TABLE      => 0xfff9,
    OFPP_NORMAL     => 0xfffa,
    OFPP_FLOOD      => 0xfffb,
    OFPP_ALL        => 0xfffc,
    OFPP_CONTROLLER => 0xfffd,
    OFPP_LOCAL      => 0xfffe,
    OFPP_NONE       => 0xffff,
};

#ofp_type
use constant {  
    OFPT_HELLO                      => 0x00,
    OFPT_ERROR                      => 0x01,
    OFPT_ECHO_REQUEST               => 0x02,
    OFPT_ECHO_REPLY                 => 0x03,
    OFPT_VENDOR                     => 0x04,
    OFPT_FEATURES_REQUEST           => 0x05,
    OFPT_FEATURES_REPLY             => 0x06,
    OFPT_GET_CONFIG_REQUEST         => 0x07,
    OFPT_GET_CONFIG_REPLY           => 0x08,
    OFPT_SET_CONFIG                 => 0x09,
    OFPT_PACKET_IN                  => 0x0a,
    OFPT_FLOW_REMOVED               => 0x0b,
    OFPT_PORT_STATUS                => 0x0c,
    OFPT_PACKET_OUT                 => 0x0d,
    OFPT_FLOW_MOD                   => 0x0e,
    OFPT_PORT_MOD                   => 0x0f,
    OFPT_STATS_REQUEST              => 0x10,
    OFPT_STATS_REPLY                => 0x11,
    OFPT_BARRIER_REQUEST            => 0x12,
    OFPT_BARRIER_REPLY              => 0x13,
    OFPT_QUEUE_GET_CONFIG_REQUEST   => 0x14,
    OFPT_QUEUE_GET_CONFIG_REPLY     => 0x15,
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

#ofp_capabilities
use constant {
    OFPC_FLOW_STATS     => (1 << 0),
    OFPC_TABLE_STATS    => (1 << 1),
    OFPC_PORT_STATS     => (1 << 2),
    OFPC_STP            => (1 << 3),
    OFPC_RESERVED       => (1 << 4),
    OFPC_IP_REASM       => (1 << 5),
    OFPC_QUEUE_STATS    => (1 << 6),
    OFPC_ARP_MATCH_IP   => (1 << 7),
};

#ofp_port_config
use constant {  
    OFPPC_PORT_DOWN     => (1 << 0),
    OFPPC_NO_STP        => (1 << 1),
    OFPPC_NO_RECV       => (1 << 2),
    OFPPC_NO_RECV_STP   => (1 << 3),
    OFPPC_NO_FLOOD      => (1 << 4),
    OFPPC_NO_FWD        => (1 << 5),
    OFPPC_NO_PACKET_IN  => (1 << 6),
};

#ofp_port_state
use constant {  
    OFPPS_LINK_DOWN     => (1 << 0),
    OFPPS_STP_LISTEN    => (0 << 8),
    OFPPS_STP_LEARN     => (1 << 8),
    OFPPS_STP_FORWARD   => (2 << 8),
    OFPPS_STP_BLOCK     => (3 << 8),
    OFPPS_STP_MASK      => (3 << 8),
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
    OFPPF_COPPER        => (1 << 7),
    OFPPF_FIBER         => (1 << 8),
    OFPPF_AUTONEG       => (1 << 9),
    OFPPF_PAUSE         => (1 << 10),
    OFPPF_PAUSE_ASYM    => (1 << 11),
};

#ofp_port_reason
use constant {   
    OFPPR_ADD       => 0x00,
    OFPPR_DELETE    => 0x01,
    OFPPR_MODIFY    => 0x02,
};

#ofp_packet_in_reason
use constant {   
    OFPR_NO_MATCH   => 0x00,
    OFPR_ACTION     => 0x01,
};

#ofp_action_type
use constant {  
    OFPAT_OUTPUT        => 0x0000,
    OFPAT_SET_VLAN_VID  => 0x0001,
    OFPAT_SET_VLAN_PCP  => 0x0002,
    OFPAT_STRIP_VLAN    => 0x0003,
    OFPAT_SET_DL_SRC    => 0x0004,
    OFPAT_SET_DL_DST    => 0x0005,
    OFPAT_SET_NW_SRC    => 0x0006,
    OFPAT_SET_NW_DST    => 0x0007,
    OFPAT_SET_TP_SRC    => 0x0008,
    OFPAT_SET_TP_DST    => 0x0009,
    OFPAT_ENQUEUE       => 0x000a,
    OFPAT_VENDOR        => 0xffff,
};

use constant {    
    OFP_VLAN_NONE   => 0xffff,
};

#ofp_flow_mod_command
use constant {  
    OFPFC_ADD           => 0x00,
    OFPFC_MODIFY        => 0x01,
    OFPFC_MODIFY_STRICT => 0x02,
    OFPFC_DELETE        => 0x03,
    OFPFC_DELETE_STRICT => 0x04,
};

#ofp_flow_wildcards
use constant {    
    OFPFW_IN_PORT       => (1 << 0),
    OFPFW_DL_VLAN       => (1 << 1),
    OFPFW_DL_SRC        => (1 << 2),
    OFPFW_DL_DST        => (1 << 3),
    OFPFW_DL_TYPE       => (1 << 4),
    OFPFW_NW_PROTO      => (1 << 5),
    OFPFW_TP_SRC        => (1 << 6),
    OFPFW_TP_DST        => (1 << 7),
    OFPFW_NW_SRC_SHIFT  => 8,
    OFPFW_NW_SRC_BITS   => 6,
    OFPFW_NW_DST_SHIFT  => 14,
    OFPFW_NW_DST_BITS   => 6,   
    OFPFW_DL_VLAN_PCP   => (1 << 20),
    OFPFW_NW_TOS        => (1 << 21),
    OFPFW_ALL           => ((1 << 22) - 1),   
};

use constant {
    OFPFW_NW_SRC_MASK   => ((1 << OFPFW_NW_SRC_BITS) - 1) << OFPFW_NW_SRC_SHIFT,
    OFPFW_NW_SRC_ALL    => (32 << OFPFW_NW_SRC_SHIFT),
    OFPFW_NW_DST_MASK   => ((1 << OFPFW_NW_DST_BITS) - 1) << OFPFW_NW_DST_SHIFT,
    OFPFW_NW_DST_ALL    => (32 << OFPFW_NW_DST_SHIFT),
    OFPFW_ICMP_TYPE     => OFPFW_TP_SRC,
    OFPFW_ICMP_CODE     => OFPFW_TP_DST,
};

use constant {
    OFP_DL_TYPE_ETH2_CUTOFF     => 0x0600,
    OFP_DL_TYPE_NOT_ETH_TYPE    => 0x05ff,
    OFP_FLOW_PERMANENT          => 0,
    OFP_DEFAULT_PRIORITY        => 0x8000,
};

#ofp_flow_mod_flags
use constant { 
    OFPFF_SEND_FLOW_REM => (1 << 0),
    OFPFF_CHECK_OVERLAP => (1 << 1),
    OFPFF_RESET_COUNTS  => (1 << 2),
};

#ofp_flow_removed_reason
use constant {
    
    OFPRR_IDLE_TIMEOUT  => 0x00,
    OFPRR_HARD_TIMEOUT  => 0x01,
    OFPRR_DELETE        => 0x02,
};

#ofp_error_type
use constant {  
    OFPET_HELLO_FAILED      => 0x0000,
    OFPET_BAD_REQUEST       => 0x0001,
    OFPET_BAD_ACTION        => 0x0002,
    OFPET_FLOW_MOD_FAILED   => 0x0003,
    OFPET_PORT_MOD_FAILED   => 0x0004,
    OFPET_QUEUE_OP_FAILED   => 0x0005,
};

#ofp_hello_failed_code
use constant {  
    OFPHFC_INCOMPATIBLE => 0x0000,
    OFPHFC_EPERM        => 0x0001,
};

#ofp_bad_request_code
use constant {
    OFPBRC_BAD_VERSION      => 0x0000,
    OFPBRC_BAD_TYPE         => 0x0001,
    OFPBRC_BAD_STAT         => 0x0002,
    OFPBRC_BAD_VENDOR       => 0x0003,
    OFPBRC_BAD_SUBTYPE      => 0x0004,
    OFPBRC_EPERM            => 0x0005,
    OFPBRC_BAD_LEN          => 0x0006,
    OFPBRC_BUFFER_EMPTY     => 0x0007,
    OFPBRC_BUFFER_UNKNOWN   => 0x0008,
};

#ofp_bad_action_code
use constant {
    OFPBAC_BAD_TYPE         => 0x0000,
    OFPBAC_BAD_LEN          => 0x0001,
    OFPBAC_BAD_VENDOR       => 0x0002,
    OFPBAC_BAD_VENDOR_TYPE  => 0x0003,
    OFPBAC_BAD_OUT_PORT     => 0x0004,
    OFPBAC_BAD_ARGUMENT     => 0x0005,
    OFPBAC_EPERM            => 0x0006,
    OFPBAC_TOO_MANY         => 0x0007,
    OFPBAC_BAD_QUEUE        => 0x0008,
};

#ofp_flow_mod_failed_code
use constant {
    OFPFMFC_ALL_TABLES_FULL     => 0x0000,
    OFPFMFC_OVERLAP             => 0x0001,
    OFPFMFC_EPERM               => 0x0002,
    OFPFMFC_BAD_EMERG_TIMEOUT   => 0x0003,
    OFPFMFC_BAD_COMMAND         => 0x0004,
    OFPFMFC_UNSUPPORTED         => 0x0005,
};

#ofp_port_mod_failed_code
use constant {
    OFPPMFC_BAD_PORT    => 0x0000,
    OFPPMFC_BAD_HW_ADDR => 0x0001,
};

#ofp_queue_op_failed_code
use constant {
    OFPQOFC_BAD_PORT    => 0x0000,
    OFPQOFC_BAD_QUEUE   => 0x0001,
    OFPQOFC_EPERM       => 0x0002,
};

#ofp_stats_types
use constant {
    OFPST_DESC      => 0x0000,
    OFPST_FLOW      => 0x0001,
    OFPST_AGGREGATE => 0x0002,
    OFPST_TABLE     => 0x0003,
    OFPST_PORT      => 0x0004,
    OFPST_QUEUE     => 0x0005,
    OFPST_VENDOR    => 0xffff,
};

#ofp_stats_reply_flags
use constant {
    OFPSF_REPLY_MORE    => (1 << 0),
};

use constant {    
    DESC_STR_LEN    => 256,
    SERIAL_NUM_LEN  => 32,
    
    OFPQ_ALL            => 0xffffffff,
    OFPQ_MIN_RATE_UNCFG => 0xffff,
};

#ofp_queue_properties
use constant {
    OFPQT_NONE      => 0x0000,
    OFPQT_MIN_RATE  => 0x0001,
};

use constant {
    OFP_HEADER_FMT  => "C C n N",
    OFP_HEADER_LEN  => 8,
};

struct ofp10_header => {
    version => '$',
    type    => '$',
    length  => '$',
    xid     => '$',
};

use constant {
    OFP_HELLO_FMT   => "a".OFP_HEADER_LEN,
    OFP_HELLO_LEN   => 8,
};

struct ofp10_hello => {
    header  => 'ofp10_header',
};

use constant {
    OFP_SWITCH_CONFIG_FMT   => "a".OFP_HEADER_LEN." n n",
    OFP_SWITCH_CONFIG_LEN   => 12,
};

struct ofp10_switch_config => {
    header          => 'ofp10_header',
    flags           => '$',
    miss_send_len   => '$',
};

use constant {
    OFP_PHY_PORT_FMT    => "n H12 A16 N N N N N N",
    OFP_PHY_PORT_LEN    => 48,
};

struct ofp10_phy_port => {
    port_no     => '$',
    hw_addr     => '@',
    name        => '@',
    config      => '$',
    state       => '$',
    curr        => '$',
    advertised  => '$',
    supported   => '$',
    peer        => '$',
};

use constant {
    OFP_SWITCH_FEATURES_FMT => "a".OFP_HEADER_LEN." H16 N C x3 N N",
    OFP_SWITCH_FEATURES_LEN => 32,
};

struct ofp10_switch_features => {
    header          => 'ofp10_header',
    datapath_id     => '$',
    n_buffers       => '$',
    n_tables        => '$',
    pad             => '@',
    capabilities    => '$',
    actions         => '$',
    ports           => '@',
};

use constant {
    OFP_PORT_STATUS_FMT => "a".OFP_HEADER_LEN." C x7 a".OFP_PHY_PORT_LEN,
    OFP_PORT_STATUS_LEN => 64,
};

struct ofp10_port_status => {
    header  => 'ofp10_header',
    reason  => '$',
    pad     => '@',
    desc    => 'ofp_phy_port',
};

use constant {
    OFP_PORT_MOD_FMT    => "a".OFP_HEADER_LEN." n H12 N N N x4",
    OFP_PORT_MOD_LEN    => 32,
};

struct ofp10_port_mod => {
    header      => 'ofp10_header',
    port_no     => '$',
    hw_addr     => '@',
    config      => '$',
    mask        => '$',
    advertise   => '$',
    pad         => '@',
};

use constant {
    OFP_PACKET_IN_FMT   => "a".OFP_HEADER_LEN." N n n C x3",
    OFP_PACKET_IN_LEN   => 20,
};

struct ofp10_packet_in => {
    header      => 'ofp10_header',
    buffer_id   => '$',
    total_len   => '$',
    in_port     => '$',
    reason      => '$',
    pad         => '$',
    data        => '@',
};

use constant {
    OFP_ACTION_OUTPUT_FMT   => "n n n n",
    OFP_ACTION_OUTPUT_LEN   => 8,
};

struct ofp10_action_output => {
    type    => '$',
    len     => '$',
    port    => '$',
    max_len => '$',
};

use constant {
    OFP_ACTION_VLAN_VID_FMT => "n n n x2",
    OFP_ACTION_VLAN_VID_LEN => 8,
};

struct ofp10_action_vlan_vid => {
    type        => '$',
    len         => '$',
    vlan_vid    => '$',
    pad         => '@',
};

use constant {
    OFP_ACTION_VLAN_PCP_FMT => "n n C x3",
    OFP_ACTION_VLAN_PCP_LEN => 8,
};

struct ofp10_action_vlan_pcp => {
    type        => '$',
    len         => '$',
    vlan_pcp    => '$',
    pad         => '@',
};

use constant {
    OFP_ACTION_DL_ADDR_FMT  => "n n H12 x6",
    OFP_ACTION_DL_ADDR_LEN  => 16,
};

struct ofp10_action_dl_addr => {
    type    => '$',
    len     => '$',
    dl_addr => '@',
    pad     => '@',
};

use constant {
    OFP_ACTION_NW_ADDR_FMT  => "n n N",
    OFP_ACTION_NW_ADDR_LEN  => 8,
};

struct ofp10_action_nw_addr => {
    type    => '$',
    len     => '$',
    nw_addr => '$',
};

use constant {
    OFP_ACTION_TP_PORT_FMT  => "n n n x2",
    OFP_ACTION_TP_PORT_LEN  => 8,
};

struct ofp10_action_tp_port => {
    type    => '$',
    len     => '$',
    tp_port => '$',
    pad     => '@',
};

use constant {
    OFP_ACTION_NW_TOS_FMT  => "n n C x3",
    OFP_ACTION_NW_TOS_LEN  => 8,
};

struct ofp10_action_nw_tos => {
    type    => '$',
    len     => '$',
    nw_tos  => '$',
    pad     => '@',
};

use constant {
    OFP_ACTION_VENDOR_HEADER_FMT  => "n n N",
    OFP_ACTION_VENDOR_HEADER_LEN  => 8,
};

struct ofp10_action_vendor_header => {
    type    => '$',
    len     => '$',
    vendor  => '$',
};

use constant {
    OFP_ACTION_HEADER_FMT  => "n n x4",
    OFP_ACTION_HEADER_LEN  => 8,
};

struct ofp10_action_header => {
    type    => '$',
    len     => '$',
    pad     => '@',
};

use constant {
    OFP_PACKET_OUT_FMT  => "a".OFP_HEADER_LEN." N n n",
    OFP_PACKET_OUT_LEN  => 16,
};

struct ofp10_packet_out => {
    header      => 'ofp10_header',
    buffer_id   => '$',
    in_port     => '$',
    actions_len => '$',
    actions     => '@', 
};

use constant {
    OFP_MATCH_FMT   => "N n H12 H12 n C x n C C x2 N N n n",
    OFP_MATCH_LEN   => 40,
};

struct ofp10_match => {
    wildcards   => '$',
    in_port     => '$',
    dl_src      => '@',
    dl_dst      => '@',
    dl_vlan     => '$',
    dl_vlan_pcp => '$',
    pad1        => '@',
    dl_type     => '$',
    nw_tos      => '$',
    nw_proto    => '$',
    pad2        => '@',
    nw_src      => '$',
    nw_dst      => '$',
    tp_src      => '$',
    tp_dst      => '$',
};

use constant {
    OFP_FLOW_MOD_FMT    => "a".OFP_HEADER_LEN." a".OFP_MATCH_LEN." Q> n n n n N n n",
    OFP_FLOW_MOD_LEN    => 72,  
};

struct ofp10_flow_mod => {
    header          => 'ofp10_header',
    match           => 'ofp10_match',
    cookie          => '$',
    command         => '$',
    idle_timeout    => '$',
    hard_timeout    => '$',
    priority        => '$',
    buffer_id       => '$',
    out_port        => '$',
    flags           => '$',
    actions         => '@',
};

use constant {
    OFP_FLOW_REMOVED_FMT    => "a".OFP_HEADER_LEN." a".OFP_MATCH_LEN." Q> n C x N N n x2 Q> Q>",
    OFP_FLOW_REMOVED_LEN    => 88,
};

struct ofp10_flow_removed => {
    header          => 'ofp10_header',
    match           => 'ofp10_match',
    cookie          => '$',
    priority        => '$',
    reason          => '$',
    pad             => '@',
    duration_sec    => '$',
    duration_nsec   => '$',
    idle_timeout    => '$',
    pad2            => '@',
    packet_count    => '$',
    byte_count      => '$',
};

use constant {
    OFP_ERROR_MSG_FMT   => "a".OFP_HEADER_LEN." n n",
    OFP_ERROR_MSG_LEN   => 12,
};

struct ofp10_error_msg => {
    header  => 'ofp10_header',
    type    => '$',
    code    => '$',
    data    => '@',
};

use constant {
    OFP_STATS_REQUEST_FMT   => "a".OFP_HEADER_LEN." n n",
    OFP_STATS_REQUEST_LEN   => 12,
};

struct ofp10_stats_request => {
    header  => 'ofp10_header',
    type    => '$',
    flags   => '$',
    body    => '@',
};

use constant {
    OFP_STATS_REPLY_FMT => "a".OFP_HEADER_LEN." n n",
    OFP_STATS_REPLY_LEN => 12,
};

struct ofp10_stats_reply => {
    header  => 'ofp10_header',
    type    => '$',
    flags   => '$',
    body    => '@',
};

use constant {
    OFP_DESC_STATS_FMT  => "Z".DESC_STR_LEN." Z".DESC_STR_LEN." Z".DESC_STR_LEN." Z".SERIAL_NUM_LEN." Z".DESC_STR_LEN,
    OFP_DESC_STATS_LEN  => 1056,
};

struct ofp10_desc_stats => {
    mfr_desc    => '@',
    hw_desc     => '@',
    sw_desc     => '@',
    serial_num  => '@',
    dp_desc     => '@',
};

use constant {
    OFP_FLOW_STATS_REQUEST_FMT  => "a".OFP_MATCH_LEN." C x n",
    OFP_FLOW_STATS_REQUEST_LEN  => 44,
};

struct ofp10_flow_stats_request => {
    match       => 'ofp_match',
    table_id    => '$',
    pad         => '@',
    out_port    => '$',
};

use constant {
    OFP_FLOW_STATS_FMT  => "n C x a".OFP_MATCH_LEN." N N n n n x6 Q> Q> Q>",
    OFP_FLOW_STATS_LEN  => 88,
};

struct ofp10_flow_stats => {
    length          => '$',
    table_id        => '$',
    pad             => '@',
    match           => 'ofp_match',
    duration_sec    => '$',
    duration_nsec   => '$',
    priority        => '$',
    idle_timeout    => '$',
    hard_timeout    => '$',
    pad2            => '@',
    cookie          => '$',
    packet_count    => '$',
    byte_count      => '$',
    actions         => '@',
};

use constant {
    OFP_AGGREGATE_STATS_REQUEST_FMT => "a".OFP_MATCH_LEN." C x n",
    OFP_AGGREGATE_STATS_REQUEST_LEN => 44,
};

struct ofp10_aggregate_stats_request => {
    match       => 'ofp_match',
    table_id    => '$',
    pad         => '@',
    out_port    => '$',
};

use constant {
    OFP_AGGREGATE_STATS_REPLY_FMT => "Q> Q> N x4",
    OFP_AGGREGATE_STATS_REPLY_LEN => 24,
};

struct ofp10_aggregate_stats_reply => {
    packet_count    => '$',
    byte_count      => '$',
    flow_count      => '$',
    pad             => '@',
};

use constant {
    OFP_TABLE_STATS_FMT => "C x3 Z".OFP_MAX_TABLE_NAME_LEN." N N N Q> Q>",
    OFP_TABLE_STATS_LEN => 64,
};

struct ofp10_table_stats => {
    table_id        => '$',
    pad             => '@',
    name            => '@',
    wildcards       => '$',
    max_entries     => '$',
    active_count    => '$',
    lookup_count    => '$',
    matched_count   => '$',
};

use constant {
    OFP_PORT_STATS_REQUEST_FMT  => "n x6",
    OFP_PORT_STATS_REQUEST_LEN  => 8,
};

struct ofp10_port_stats_request => {
    port_no => '$',
    pad     => '@',
};

use constant {
    OFP_PORT_STATS_FMT  => "n x6 Q> Q> Q> Q> Q> Q> Q> Q> Q> Q> Q> Q>",
    OFP_PORT_STATS_LEN  => 104,
};

struct ofp10_port_stats => {
    port_no         => '$',
    pad             => '@',
    rx_packets      => '$',
    tx_packets      => '$',
    rx_bytes        => '$',
    tx_bytes        => '$',
    rx_dropped      => '$',
    tx_dropped      => '$',
    rx_errors       => '$',
    tx_errors       => '$',
    rx_frame_err    => '$',
    rx_over_err     => '$',
    rx_crc_err      => '$',
    collisions      => '$',
};

use constant {
    OFP_VENDOR_HEADER_FMT   => "a".OFP_HEADER_LEN." N",
    OFP_VENDOR_HEADER_LEN   => 12,
};

struct ofp10_vendor_header => {
    header  => 'ofp10_header',
    vendor  => '$',
};

use constant {
    OFP_QUEUE_PROP_HEADER_FMT   => "n n x4",
    OFP_QUEUE_PROP_HEADER_LEN   => 8,
};

struct ofp10_queue_prop_header => {
    property    => '$',
    len         => '$',
    pad         => '@',
};

use constant {
    OFP_QUEUE_PROP_MIN_RATE_FMT => "a".OFP_QUEUE_PROP_HEADER_LEN." n x6",
    OFP_QUEUE_PROP_MIN_RATE_LEN => 16,
};

struct ofp10_queue_prop_min_rate => {
    prop_header => 'ofp_queue_prop_header',
    rate        => '$',
    pad         => '@',
};

use constant {
    OFP_PACKET_QUEUE_FMT    => "N n x2",
    OFP_PACKET_QUEUE_LEN    => 8,
};

struct ofp10_packet_queue => {
    queue_id    => '$',
    len         => '$',
    pad         => '@',
    properties  => '@',
};

use constant {
    OFP_QUEUE_GET_CONFIG_REQUEST_FMT    => "a".OFP_HEADER_LEN." n x2",
    OFP_QUEUE_GET_CONFIG_REQUEST_LEN    => 12,
};

struct ofp10_queue_get_config_request => {
    header  => 'ofp10_header',
    port    => '$',
    pad     => '@',
};

use constant {
    OFP_QUEUE_GET_CONFIG_REPLY_FMT  => "a".OFP_HEADER_LEN." n x6",
    OFP_QUEUE_GET_CONFIG_REPLY_LEN  => 16,
};

struct ofp10_queue_get_config_reply => {
    header  => 'ofp10_header',
    port    => '$',
    pad     => '@',
    queues  => '@',
};

use constant {
    OFP_ACTION_ENQUEUE_FMT  => "n n n x6 N",
    OFP_ACTION_ENQUEUE_LEN  => 16,
};

struct ofp10_action_enqueue => {
    type        => '$',
    len         => '$',
    port        => '$',
    pad         => '@',
    queue_id    => '$',
};

use constant {
    OFP_QUEUE_STATS_REQUEST_FMT => "n x2 N",
    OFP_QUEUE_STATS_REQUEST_LEN => 8,
};

struct ofp10_queue_stats_request => {
    port_no     => '$',
    pad         => '@',
    queue_id    => '$',
};

use constant {
    OFP_QUEUE_STATS_FMT => "n x2 N Q> Q> Q>",
    OFP_QUEUE_STATS_LEN => 32,
};

struct ofp10_queue_stats => {
    port_no     => '$',
    pad         => '@',
    queue_id    => '$',
    tx_bytes    => '$',
    tx_packets  => '$',
    tx_errors   => '$',
};

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    return $self;
}

sub ofp_header_decode {
    my $self = shift;
    my $ofp_header_raw = shift;
    my $ofp_header = ofp10_header->new();
    my($version, $type, $length, $xid) = unpack(OFP_HEADER_FMT, $ofp_header_raw);
    $ofp_header->version($version);
    $ofp_header->type($type);
    $ofp_header->length($length);
    $ofp_header->xid($xid);
    return $ofp_header;
}

sub hello {
    my $self = shift;
    my $sock = shift;
    my $ofp_header = shift;
    my $ofp_header_raw = pack(OFP_HEADER_FMT,
                                OFP_VERSION,
                                OFPT_HELLO,
                                OFP_HEADER_LEN,
                                $ofp_header->xid);
    $sock->send($ofp_header_raw);
    $self->features_request($sock, $ofp_header);
    $self->config_request($sock, $ofp_header);
}

sub features_request {
    my $self = shift;
    my $sock = shift;
    my $ofp_header = shift;
    my $ofp_header_raw = pack(OFP_HEADER_FMT,
                                OFP_VERSION,
                                OFPT_FEATURES_REQUEST,
                                OFP_HEADER_LEN,
                                $ofp_header->xid);
    $sock->send($ofp_header_raw);
}

sub config_request {
    my $self = shift;
    my $sock = shift;
    my $ofp_header = shift;
    my $ofp_header_raw = pack(OFP_HEADER_FMT,
                                OFP_VERSION,
                                OFPT_GET_CONFIG_REQUEST,
                                OFP_HEADER_LEN,
                                $ofp_header->xid);
    $sock->send($ofp_header_raw);
}

sub echo_reply {
    my $self = shift;
    my $sock = shift;
    my $ofp_header = shift;
    my $ofp_header_raw = pack(OFP_HEADER_FMT,
                                OFP_VERSION,
                                OFPT_ECHO_REPLY,
                                OFP_HEADER_LEN,
                                $ofp_header->xid);
    $sock->send($ofp_header_raw);
}

sub proc {
    my $self = shift;
    my $sock = shift;
    my $ofp_header_raw;
    my $ofp_data_raw;
    $sock->recv($ofp_header_raw, OFP_HEADER_LEN);
    my $ofp_header = $self->ofp_header_decode($ofp_header_raw);
    print $ofp_header->version."\n";
    print $ofp_header->type."\n";
    print $ofp_header->length."\n";
    print $ofp_header->xid."\n";
    if($ofp_header->version != OFP_VERSION) {
        return 1;
    }
    if($ofp_header->type == OFPT_HELLO) {
        $self->hello($sock, $ofp_header);
    }
    if($ofp_header->length > OFP_HEADER_LEN) {
        $sock->recv($ofp_data_raw, $ofp_header->length - 8);
    }
    if($ofp_header->type == OFPT_ECHO_REQUEST) {
        $self->echo_reply($sock, $ofp_header);
    }
    return 0;
}

1;


