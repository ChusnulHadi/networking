# Mikrotik Firewall Allow PPTP Protocol

/ip firewall filter
add action=accept chain=input comment="Allow PPTP" disabled=no dst-port=1723 protocol=tcp