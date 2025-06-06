# Mikrotik Firewall Trap Incoming HTTP Protocol

/ip firewall address-list
add list=STAGE-1
add list=STAGE-2
add list=STAGE-3
add list=BLACKLIST

/ip firewall filter
add action=drop chain=input comment="Drop HTTP" disabled=no dst-port=80 protocol=tcp src-address-list=BLACKLIST connection-state=invalid
add action=add-src-to-address-list address-list=BLACKLIST address-list-timeout=7d chain=input comment="Blacklist HTTP" disabled=no dst-port=80 protocol=tcp src-address-list=STAGE-3 connection-state=!related,established
add action=add-src-to-address-list address-list=STAGE-3 address-list-timeout=10m chain=input comment="Stage 3 HTTP" disabled=no dst-port=80 protocol=tcp src-address-list=STAGE-2 connection-state=!related,established
add action=add-src-to-address-list address-list=STAGE-2 address-list-timeout=5m chain=input comment="Stage 2 HTTP" disabled=no dst-port=80 protocol=tcp src-address-list=STAGE-1 connection-state=!related,established
add action=add-src-to-address-list address-list=STAGE-1 address-list-timeout=3m chain=input comment="Stage 1 HTTP" disabled=no dst-port=80 protocol=tcp connection-state=invalid,new
