# Mikrotik Firewall Trap Telnet Protocol

/ip firewall address-list
add list=STAGE-1
add list=STAGE-2
add list=STAGE-3
add list=BLACKLIST

/ip firewall filter
add action=drop chain=input comment="Drop Telnet" disabled=no dst-port=23 protocol=tcp src-address-list=BLACKLIST connection-state=invalid
add action=add-src-to-address-list address-list=BLACKLIST address-list-timeout=1d chain=input comment="Blacklist Telnet" disabled=no dst-port=23 protocol=tcp src-address-list=STAGE-3 connection-state=invalid
add action=add-src-to-address-list address-list=STAGE-3 address-list-timeout=10m chain=input comment="Stage 3 Telnet" disabled=no dst-port=23 protocol=tcp src-address-list=STAGE-2 connection-state=invalid
add action=add-src-to-address-list address-list=STAGE-2 address-list-timeout=5m chain=input comment="Stage 2 Telnet" disabled=no dst-port=23 protocol=tcp src-address-list=STAGE-1 connection-state=invalid
add action=add-src-to-address-list address-list=STAGE-1 address-list-timeout=3m chain=input comment="Stage 1 Telnet" disabled=no dst-port=23 protocol=tcp connection-state=invalid