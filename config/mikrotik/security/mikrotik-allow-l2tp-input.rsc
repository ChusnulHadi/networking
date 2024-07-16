# Mikrotik Firewall Allow L2TP Protocol

/ip firewall filter
add action=accept chain=input comment="Allow L2TP" disabled=no dst-port=1701 protocol=udp