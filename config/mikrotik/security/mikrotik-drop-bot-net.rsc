# Mikrotik Drop Bot Net

/ip firewall filter
add action=drop chain=forward comment="Drop BotNet" disabled=no dst-port=23,450 protocol=tcp
add action=drop chain=forward comment="Drop BotNet" disabled=no dst-port=23,450 protocol=udp
