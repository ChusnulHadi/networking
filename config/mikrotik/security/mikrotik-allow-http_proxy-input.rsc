# Mikrotik Firewall Allow HTTP Proxy Protocol

/ip firewall filter
add action=accept chain=input comment="Allow HTTP Proxy" disabled=no dst-port=8080 protocol=tcp