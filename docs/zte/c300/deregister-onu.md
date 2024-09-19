# Deregister ONU on OLT ZTE C300

The operator can deregister the ONU by entering configuration.

```terminal
ZXAN(config)# interface GPON-OLT-PORTS
ZXAN(config-if)# no onu ONU_IDs
.[Successful]
```

The above command will delete onu based on ONU ID. Then remove the ONU from the PON whitelist.

```terminal
ZXAN(config)# pon
ZXAN(config-pon)# no whitelist gpon sn ONU_SN
```

Check The Result:

```terminal
ZXAN# show gpon onu uncfg

OnuIndex                 Sn                  State
---------------------------------------------------------------------
gpon-onu_1/1/1:1         ONU_SN        unknown
```
