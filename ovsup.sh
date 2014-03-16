ovs-vsctl add-br br0
ovs-vsctl add-port br0 wlan0 -- set Interface wlan0 ofport_request=1
ovs-vsctl add-port br0 eth0.2 -- set Interface eth0.2 ofport_request=2
ovs-vsctl add-port br0 eth0.3 -- set Interface eth0.3 ofport_request=3
ovs-vsctl add-port br0 eth0.4 -- set Interface eth0.4 ofport_request=4
ovs-vsctl add-port br0 eth0.5 -- set Interface eth0.3 ofport_request=5
ovs-vsctl set bridge br0 protocols=OpenFlow13
ovs-vsctl set-controller br0 tcp:127.0.0.1:6653
