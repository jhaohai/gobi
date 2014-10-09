#!/usr/bin/python

"""Custom topology

   host --- switch --- switch --- host
   h1                      h3
     \                   /
       switch --- router 
     /                   \
   h2                      h4

"""

from mininet.topo import Topo
from mininet.net import Mininet
from mininet.node import OVSKernelSwitch, RemoteController
from mininet.cli import CLI
from mininet.log import setLogLevel

if __name__ == '__main__':
    setLogLevel('info')
    net = Mininet(controller=RemoteController)
    c0 = RemoteController("custom", ip='10.109.242.209')
    net.addController( c0 )
    
    # Add hosts and switches
    h1 = net.addHost( 'h1', ip='10.0.0.2/24' )
    h2 = net.addHost( 'h2', ip='10.0.0.3/24' )
    h3 = net.addHost( 'h3', ip='20.0.0.2/24' )
    h4 = net.addHost( 'h4', ip='30.0.0.2/24' )
    s1 = net.addSwitch( 's1', dpid='0000000000000001' )
    r1 = net.addSwitch( 'r1', dpid='0000000000000002' )

    # Add links
    net.addLink( h1, s1 )
    net.addLink( h2, s1 )
    net.addLink( h3, r1 )
    net.addLink( h4, r1 )
    net.addLink( s1, r1 )
    
    net.start()
    # Configure host
    h1.setMAC( '00:00:00:00:00:01', 'h1-eth0')
    h1.setDefaultRoute('dev h1-eth0 via 10.0.0.1')
    h1.setARP( '10.0.0.1', '20:00:00:00:00:00' )  
    
    h2.setMAC( '00:00:00:00:00:02', 'h2-eth0')
    h2.setDefaultRoute('dev h2-eth0 via 10.0.0.1')
    h2.setARP( '10.0.0.1', '20:00:00:00:00:00' )
    
    h3.setMAC( '00:00:00:00:00:03', 'h3-eth0')
    h3.setDefaultRoute('dev h3-eth0 via 20.0.0.1')
    h3.setARP( '20.0.0.1', '20:00:00:00:00:00' )
    
    h4.setMAC( '00:00:00:00:00:04', 'h4-eth0')
    h4.setDefaultRoute('dev h4-eth0 via 30.0.0.1')
    h4.setARP( '30.0.0.1', '20:00:00:00:00:00' )
    
    #net.start()
    CLI(net)
    net.stop()
