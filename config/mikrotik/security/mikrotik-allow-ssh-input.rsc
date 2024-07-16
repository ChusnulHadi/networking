# Mikrotik Firewall Allow SSH Protocol

/ip firewall filter
add action=accept chain=input comment="Allow SSH" disabled=no dst-port=22 protocol=tcp
