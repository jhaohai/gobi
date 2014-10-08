"""Custom topology

   host --- switch --- switch --- host
   h1                      h3
     \                   /
       switch --- router 
     /                   \
   h2                      h4

"""

from mininet.topo import Topo

class MyTopo( Topo ):
    "Simple topology example."

    def __init__( self ):
        "Create custom topo."

        # Initialize topology
        Topo.__init__( self )

        # Add hosts and switches
        h1 = self.addHost( 'h1' )
        h2 = self.addHost( 'h2' )
        h3 = self.addHost( 'h3' )
        h4 = self.addHost( 'h4' )
        s1 = self.addSwitch( 's1', dpid='0000000000000001' )
        r1 = self.addSwitch( 'r1', dpid='0000000000000002' )

        # Add links
        self.addLink( h1, s1 )
        self.addLink( h2, s1 )
        self.addLink( h3, r1 )
        self.addLink( h4, r1 )
        
        # Configure host
        h1.setARP( '10.0.0.1', '20:00:00:00:00:00' )
        h1.setIP( '10.0.0.2', 24 )
        h1.setMAC( '00:00:00:00:00:01')
        h1.setDefaultRoute()
        
        h2.setARP( '10.0.0.1', '20:00:00:00:00:00' )
        h2.setIP( '10.0.0.3', 24 )
        h2.setMAC( '00:00:00:00:00:02')
        h1.setDefaultRoute()
        
        h3.setARP( '20.0.0.1', '20:00:00:00:00:00' )
        h3.setIP( '20.0.0.2', 24 )
        h3.setMAC( '00:00:00:00:00:03')
        h1.setDefaultRoute()
        
        h4.setARP( '30.0.0.1', '20:00:00:00:00:00' )
        h4.setIP( '30.0.0.2', 24 )
        h4.setMAC( '00:00:00:00:00:04')
        h1.setDefaultRoute()


topos = { 'mytopo': ( lambda: MyTopo() ) }
