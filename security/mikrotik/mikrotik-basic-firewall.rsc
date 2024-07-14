# Mikrotik Basic Firewall

# Drop Invalid Connections
/ip firewall filter add action=drop chain=forward comment="Drop Invalid Connections" connection-state=invalid disabled=no

# Allow Established and Related Connections
/ip firewall filter add action=accept chain=forward comment="Allow Established and Related Connections" connection-state=established,related disabled=no

# Allow ICMP
/ip firewall filter add action=accept chain=input comment="Allow ICMP" disabled=no protocol=icmp

# Allow DNS
/ip firewall filter add action=accept chain=input comment="Allow DNS" disabled=no dst-port=53 protocol=udp
/ip firewall filter add action=accept chain=input comment="Allow DNS" disabled=no dst-port=53 protocol=tcp

# Allow NTP
/ip firewall filter add action=accept chain=input comment="Allow NTP" disabled=no dst-port=123 protocol=udp

# Allow HTTP
/ip firewall filter add action=accept chain=input comment="Allow HTTP" disabled=no dst-port=80 protocol=tcp

# Allow HTTPS
/ip firewall filter add action=accept chain=input comment="Allow HTTPS" disabled=no dst-port=443 protocol=tcp

# Allow DHCP Client
/ip firewall filter add action=accept chain=input comment="Allow DHCP Client" disabled=no dst-port=68 protocol=udp

# Allow DHCP Server
/ip firewall filter add action=accept chain=input comment="Allow DHCP Server" disabled=no dst-port=67 protocol=udp

# Allow SNMP
/ip firewall filter add action=accept chain=input comment="Allow SNMP" disabled=no dst-port=161 protocol=udp

# Allow BGP Peer
/ip firewall filter add action=accept chain=input comment="Allow BGP Peer" disabled=no dst-port=179 protocol=tcp

# Allow RIP Protocol
/ip firewall filter add action=accept chain=input comment="Allow RIP Protocol" disabled=no dst-port=520-521 protocol=udp

# Allow LDP Protocol
/ip firewall filter add action=accept chain=input comment="Allow LDP Protocol" disabled=no dst-port=646 protocol=tcp
/ip firewall filter add action=accept chain=input comment="Allow LDP Protocol" disabled=no dst-port=646 protocol=udp

# Allow BTEST Server
/ip firewall filter add action=accept chain=input comment="Allow BTEST Server" disabled=no dst-port=2000 protocol=TCP
/ip firewall filter add action=accept chain=input comment="Allow BTEST Server" disabled=no dst-port=2000 protocol=UDP

# Allow Neighbors Discovery
/ip firewall filter add action=accept chain=input comment="Allow Neighbors Discovery" disabled=no dst-port=5678 protocol=udp

# Allow Winbox
/ip firewall filter add action=accept chain=input comment="Allow Winbox" disabled=no dst-port=8291 protocol=tcp

# Allow MAC Winbox
/ip firewall filter add action=accept chain=input comment="Allow MAC Winbox" disabled=no dst-port=20561 protocol=udp

# Allow Telnet
/ip firewall filter add action=accept chain=input comment="Allow Telnet" disabled=no dst-port=23 protocol=tcp

# Allow SSH
/ip firewall filter add action=accept chain=input comment="Allow SSH" disabled=no dst-port=22 protocol=tcp

# Drop All
/ip firewall filter add action=drop chain=input comment="Drop All" disabled=no