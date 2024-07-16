# Mikrotik Firewall Allow FTP Protocol

/ip firewall filter
add action=accept chain=input comment="Allow FTP" disabled=no dst-port=21 protocol=tcp
add action=accept chain=input comment="Allow FTP Data" disabled=no dst-port=20 protocol=tcp