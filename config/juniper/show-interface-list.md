
# Show Interface

## Show All Interface List

```shell
> show interfaces
```

This command will show all interface list with spesific detail like example below:

```shell
Physical interface: lc-0/0/0, Enabled, Physical link is Up
  Interface index: 136, SNMP ifIndex: 510
  Speed: 800mbps
  Device flags   : Present Running
  Link flags     : None
  Last flapped   : Never
    Input packets : 0
    Output packets: 0

  Logical interface lc-0/0/0.32769 (Index 328) (SNMP ifIndex 511)
    Flags: Encapsulation: ENET2
    Bandwidth: 0
    Input packets : 0
    Output packets: 0
    Protocol vpls, MTU: Unlimited
      Flags: Is-Primary
```

## Show Specified Interface

We Assumming your interface name is ge-1/0/1

```shell
> show interfaces ge-1/0/1
```

This command will show more details about specific interface. Below is example of output:

```shell
Physical interface: ge-1/0/1, Enabled, Physical link is Down
  Interface index: 144, SNMP ifIndex: 524
  Link-level type: Ethernet, MTU: 1514, MRU: 1522, LAN-PHY mode, Speed: 1000mbps, BPDU Error: None,
  MAC-REWRITE Error: None, Loopback: Disabled, Source filtering: Disabled, Flow control: Enabled,
  Auto-negotiation: Enabled, Remote fault: Online
  Pad to minimum frame size: Disabled
  Device flags   : Present Running Down
  Interface flags: Hardware-Down SNMP-Traps Internal: 0x0
  Link flags     : None
  CoS queues     : 8 supported, 8 maximum usable queues
  Current address: e8:b6:c2:f9:33:61, Hardware address: e8:b6:c2:f9:33:61
  Last flapped   : 2024-07-15 17:24:43 UTC (00:18:12 ago)
  Input rate     : 0 bps (0 pps)
  Output rate    : 0 bps (0 pps)
  Active alarms  : LINK
  Active defects : LINK
  Interface transmit statistics: Disabled
```

## Show Diagnostics Optics for Optical Interfaces

This command will only available for interface with optical devices. We assuming will check optical status for interface ge-1/0/0

```shell
> show interfaces diagnostics optics ge-1/0/0/0
```

This command will show all details about the optical modules like laser biar, laser power, module temperature, module voltage, etc. Below is example of output:

```shell
Physical interface: ge-1/0/0
    Laser bias current                        :  21.382 mA
    Laser output power                        :  0.4640 mW / -3.33 dBm
    Module temperature                        :  29 degrees C / 85 degrees F
    Module voltage                            :  3.2680 V
    Receiver signal average optical power     :  0.0353 mW / -14.52 dBm
    Laser bias current high alarm             :  Off
    Laser bias current low alarm              :  Off
    Laser bias current high warning           :  Off
    Laser bias current low warning            :  Off
    Laser output power high alarm             :  Off
    Laser output power low alarm              :  Off
    Laser output power high warning           :  Off
    Laser output power low warning            :  Off
    Module temperature high alarm             :  Off
    Module temperature low alarm              :  Off
    Module temperature high warning           :  Off
    Module temperature low warning            :  Off
    Module voltage high alarm                 :  Off
    Module voltage low alarm                  :  Off
    Module voltage high warning               :  Off
    Module voltage low warning                :  Off
    Laser rx power high alarm                 :  Off
    Laser rx power low alarm                  :  Off
    Laser rx power high warning               :  Off
    Laser rx power low warning                :  Off
    Laser bias current high alarm threshold   :  80.000 mA
    Laser bias current low alarm threshold    :  0.000 mA
    Laser bias current high warning threshold :  80.000 mA
    Laser bias current low warning threshold  :  2.000 mA
    Laser output power high alarm threshold   :  1.9990 mW / 3.01 dBm
    Laser output power low alarm threshold    :  0.0010 mW / -30.00 dBm
    Laser output power high warning threshold :  1.0000 mW / 0.00 dBm
    Laser output power low warning threshold  :  0.0010 mW / -30.00 dBm
    Module temperature high alarm threshold   :  85 degrees C / 185 degrees F
    Module temperature low alarm threshold    :  -40 degrees C / -40 degrees F
    Module temperature high warning threshold :  70 degrees C / 158 degrees F
    Module temperature low warning threshold  :  0 degrees C / 32 degrees F
    Module voltage high alarm threshold       :  3.600 V
    Module voltage low alarm threshold        :  3.000 V
    Module voltage high warning threshold     :  3.600 V
    Module voltage low warning threshold      :  3.000 V
    Laser rx power high alarm threshold       :  1.9998 mW / 3.01 dBm
    Laser rx power low alarm threshold        :  0.0001 mW / -40.00 dBm
    Laser rx power high warning threshold     :  1.0000 mW / 0.00 dBm
    Laser rx power low warning threshold      :  0.0001 mW / -40.00 dBm
```

## Show Diagnostic Optics Only Specified Value

Use command `match` follow with specified key to get. Assuming we will check only the receives signal on optical devices:

```shell
> show interfaces diagnostics optics ge-1/0/0 | match "optical power"  
```

This command will only show match key contains with "optical power" string. Below is example of output:

```shell
Receiver signal average optical power     :  0.0353 mW / -14.52 dBm
```


## Show Interfaces Speed

This command will get the details of interface but only show the key contains with "Speed" to get link speed status.

```shell
> show interfaces ge-1/0/0 | match "Speed"
```

The output will only display key contains with match string "Speed". Below is example of output:

```shell
 Link-level type: Ethernet, MTU: 1518, MRU: 1526, LAN-PHY mode, Speed: 1000mbps, BPDU Error: None,
```
