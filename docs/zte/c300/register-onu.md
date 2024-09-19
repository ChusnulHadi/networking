# Register ONU on OLT ZTE C300

To register onu, you can do this by looking at the onu list, registering on the interface and adding to the whitelist.

## Check Unconfigured ONU

```terminal
ZXAN# show gpon onu uncfg

OnuIndex                 Sn                  State
---------------------------------------------------------------------
gpon-onu_1/1/1:1         ONU_SN        unknown
```

You nedd to get ONU Serial Number to register devices.

## Add ONU on Interface

```terminal
ZXAN#configure terminal
ZXAN(config)#interface GPON_OLT_PORTS
ZXAN(config-if)#onu ONU_ID type ONU_TYPE sn ONU_SN
```

## Add ONU to Whitelist

```terminal
ZXAN(config)#pon
ZXAN(config-pon)#whitelist gpon sn ONU_SN
```

## Check Configured ONU

ONUs that have been registered will be visible in `gpon onu state`

```terminal
OnuIndex   Admin State  OMCC State  Phase State  Channel    
--------------------------------------------------------------
1/1/1:1     enable       enable      working      1(GPON)
1/1/1:2     enable       enable      working      1(GPON)
1/1/1:3     enable       enable      working      1(GPON)
ONU Number: 3/3
```
