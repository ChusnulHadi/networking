# Config GPON ONU Interface

On the GPON config ONU interface, we can configure the OLT side such as name, description, gemport, tconf and service port.

```txt
ZXAN(config)# interface gpon-onu_1/1/1:1
ZXAN(config-if)# name ONT2
ZXAN(config-if)# description ONT2
ZXAN(config-if)# tcont 1 name BRIDGE profile 1000M
ZXAN(config-if)# gemport 1 name BRIDGE tcont 1
ZXAN(config-if)# service-port 1 vport 1 user-vlan 10 vlan 10 
```

##### T-Cont (Transmission Control) 
Tcont control upstream bandwidth with several type allocation like:
- type 1 : Fixed Bandwidth
- type 2 : Assured Bandwidth
- type 3 : Assured + Maximum Bandwidth
- type 4 : Best Effort
- type 5 : Assured + Best Effort Combo

in the example above we have defined tcont with type 4 Best Effort Gigabit upstream.

##### GEM Port (Gpon Encapsulation Method Port)
Gemport is a logical channel that bringing traffic between OLT and ONT inside TCont. Every service like Internet, VoIP, IPTV usually have different Gemport.

- single TCont able to have many Gemport
- gemport decide mapping traffic by vlan or service type

#### Service Port
Service port is a service endpoint that connects gemport to the vlan on the Uplink side of the OLT. It determines how traffic from ONT is forwarded to  the Upstream Network
