# Mikrotik Firewall Allow Telnet Protocol

/ip firewall filter
add action=accept chain=input comment="Allow Telnet" disabled=no dst-port=23 protocol=tcp