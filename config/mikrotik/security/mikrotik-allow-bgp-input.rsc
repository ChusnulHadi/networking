# Mikrotik Allow BGP Input

/ip firewall filter
add comment="Allow BGP Peer" chain=input protocol=tcp port=179 action=accept 
