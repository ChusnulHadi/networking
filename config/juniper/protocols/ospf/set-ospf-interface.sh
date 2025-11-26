# register interface which will use OSPF in specific area ID

set protocols ospf area 0.0.0.0 interface ge-0/0/0.0
set protocols ospf area 0.0.0.0 interface ge-0/0/1.0
set protocols ospf area 0.0.0.0 interface lo0.0 passive
set protocols ospf area 0.0.0.1 interface ge-0/0/2.0

# interface with no OSPF or loopback interface should be set to passive. This will be save resource
