# Mikrotik Allow OSPF Protocol

/ip firewall filter add comment="Allow OSPF Protocol" chain=input protocol=ospf action=accept
