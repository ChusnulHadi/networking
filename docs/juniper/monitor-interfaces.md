
# Monitoring Interfaces

## Monitor All Interfaces Traffic

This command will show interface list with current updated packet transfer or bit transfer.

```shell
> monitor interfaces traffic [detail]
```

Use detail command if you want to show detail information about interfaces. Below is example of output:

```shell
Interface    Link     Input bytes        (bps)      Output bytes        (bps) Description
 lc-0/0/0      Up               0                              0
 pfh-0/0/0     Up               0                              0
 xe-0/0/0    Down               0          (0)                 0          (0)
 xe-0/0/1    Down               0          (0)                 0          (0)
 xe-0/0/2    Down               0          (0)                 0          (0)
 xe-0/0/3    Down               0          (0)                 0          (0)
 ge-1/0/0      Up         9735722       (2200)           1151644       (1152)
 ge-1/0/1    Down               0          (0)                 0          (0)
 ge-1/0/2    Down               0          (0)                 0          (0)
 ge-1/0/3    Down               0          (0)                 0          (0)
```

## Monitor Specified Interface Traffic

This command will get information about current traffic on interfaces. We assuming that we will check current traffic on interface ge-1/0/0.

```shell
> monitor interfaces ge-1/0/0
```

Below is the example of output:

```shell
Interface: ge-1/0/0, Enabled, Link is Up
Encapsulation: Ethernet, Speed: 1000mbps
Traffic statistics:                                              Current delta
  Input bytes:                   9575003 (6048 bps)                     [3022]
  Output bytes:                   964964 (2016 bps)                     [6128]
  Input packets:                   88518 (7 pps)                          [35]
  Output packets:                   6598 (1 pps)                          [14]
Error statistics:
  Input errors:                        0                                   [0]
  Input drops:                         0                                   [0]
  Input framing errors:                0                                   [0]
  Policed discards:                    0                                   [0]
  L3 incompletes:                      0                                   [0]
  L2 channel errors:                   0                                   [0]
  L2 mismatch timeouts:                0  Carrier transitions:             [0]
```
