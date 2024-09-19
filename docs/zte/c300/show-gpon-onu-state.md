# Show GPON ONU State on OLT ZTE C300

To display onu status, this can be done at the operator level by performing the following command.

```terminal
ZXAN# show gpon onu state GPON-OLT-PORTS
```

The output will be displayed as follows

```terminal
OnuIndex   Admin State  OMCC State  Phase State  Channel    
--------------------------------------------------------------
1/1/1:1     enable       enable      working      1(GPON)
1/1/1:2     enable       enable      working      1(GPON)
1/1/1:3     enable       enable      working      1(GPON)
ONU Number: 3/3
```

## State Status

### Phase State

- working: the onu is registered, configure, and authenticated.
- logging: the onu is recently boot and will continue to start

### Admin State

- enable: the onu is registered.
- disable: the onu is unregitered.

### OMCC State

- enable: the onu is authenticated from PON.
- disable: the onu is not yet authenticate from PON.
