# Mikrotik Firewall Allow HTTP Protocol

/ip firewall filter
add action=accept chain=input comment="Allow HTTP" disabled=no dst-port=80 protocol=tcp