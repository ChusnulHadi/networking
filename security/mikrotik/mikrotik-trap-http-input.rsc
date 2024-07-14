# Mikrotik Firewall Trap Incoming HTTP Protocol

/ip firewall address-list
add list=STAGE-1
add list=STAGE-2
add list=STAGE-3
add list=BLACKLIST

/ip firewall filter
add action=drop chain=input comment="Drop HTTP" disabled=no dst-port=80 protocol=tcp src-address-list=BLACKLIST
add action=add-src-to-address-list address-list=BLACKLIST address-list-timeout=1d chain=input comment="Blacklist HTTP" disabled=no dst-port=80 protocol=tcp src-address-list=STAGE-3
add action=add-src-to-address-list address-list=STAGE-3 address-list-timeout=10m chain=input comment="Stage 3 HTTP" disabled=no dst-port=80 protocol=tcp src-address-list=STAGE-2
add action=add-src-to-address-list address-list=STAGE-2 address-list-timeout=5m chain=input comment="Stage 2 HTTP" disabled=no dst-port=80 protocol=tcp src-address-list=STAGE-1
add action=add-src-to-address-list address-list=STAGE-1 address-list-timeout=3m chain=input comment="Stage 1 HTTP" disabled=no dst-port=80 protocol=tcp