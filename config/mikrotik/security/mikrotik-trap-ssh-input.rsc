# Mikrotik Firewall Trap Incoming SSH Protocol

/ip firewall address-list
add list=STAGE-1
add list=STAGE-2
add list=STAGE-3
add list=BLACKLIST

/ip firewall filter
add action=drop chain=input comment="Drop SSH" disabled=no dst-port=22 protocol=tcp src-address-list=BLACKLIST
add action=add-src-to-address-list address-list=BLACKLIST address-list-timeout=1d chain=input comment="Blacklist SSH" disabled=no dst-port=22 protocol=tcp src-address-list=STAGE-3 connection-state=!established,related
add action=add-src-to-address-list address-list=STAGE-3 address-list-timeout=10m chain=input comment="Stage 3 SSH" disabled=no dst-port=22 protocol=tcp src-address-list=STAGE-2 connection-state=!established,related
add action=add-src-to-address-list address-list=STAGE-2 address-list-timeout=1m chain=input comment="Stage 2 SSH" disabled=no dst-port=22 protocol=tcp src-address-list=STAGE-1 connection-state=!established,related
add action=add-src-to-address-list address-list=STAGE-1 address-list-timeout=1m chain=input comment="Stage 1 SSH" disabled=no dst-port=22 protocol=tcp connection-state=invalid,new
