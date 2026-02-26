# Config GPON ONU Interface

On the GPON config ONU interface, we can configure the OLT side such as name, description, gemport, tconf and service port.

```sh
ZXAN(config)# interface gpon-onu_1/1/1:1
ZXAN(config-if)# name ONT2
ZXAN(config-if)# description ONT2
ZXAN(config-if)# tcont 1 name BRIDGE profile 1000M
ZXAN(config-if)# gemport 1 name BRIDGE tcont 1
ZXAN(config-if)# service-port 1 vport 1 user-vlan 10 vlan 10 
```

