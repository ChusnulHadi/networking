# Access OLT ZTE C300

ZTE can be accessed using telnet. Default local ip ZTE C300 is 136.1.1.100 using subnet mask /16. The default username is `zte` and default password is `zte`.

## Privileged

ZTE C300 has privilege access at the operator level which requires a password for the operator. The default password is "zxr10". To be able to access the operator level, you can do this by:

```terminal
ZXAN> enable
```

Operator level can perform operations such as reboot, display configuration, save configuration, ping, and traceroute. you can press the `?` to display the available options

## Configure

ZTE C300 can be configured via the terminal. You cannot configure if your level is not Operator. You need to enter the configuration by performing the following command

```terminal
ZXAN# configure terminal
```

If you have entered the configuration session, you will see the label change as follows.

```terminal
ZXAN(config)# 
```

Any changes made will be immediately implemented by the system. However the configuration has not been saved so it will be lost after reboot. You need to perform a `write` operation at the operator level to save the configuration.
