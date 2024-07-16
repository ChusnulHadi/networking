# Mikrotik Firewall Allow HTTPS Protocol

/ip firewall filter
add action=accept chain=input comment="Allow HTTPS" disabled=no dst-port=443 protocol=tcp