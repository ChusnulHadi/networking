# L2TP

## Configuring L2TP Server

### Set authentication mode

```shell
set vpn l2tp remote-access authentication mode local
```

Set authentication backend. The configured authentication backend is used for all queries.
- radius: All authentication queries are handle by a configured RADIUS server
- local: All authenctication queries are handled locally

### Set user and password authentication

```shell
set vpn l2tp remote-access authentication local-users username <user> password <pass>
```

Create \<user\> for local authentication on this system. The users password will be set to \<pass\>.

### Create client ip pool

```shell
set vpn l2tp remote-access client-ip-pool <POLL-NAME> range <x.x.x.x-x.x.x.x | x.x.x.x/x>
```

use this command to define the first IP address of a pool of addresses to be given to l2tp clients. If notation `x.x.x.x-x.x.x.x`, it must be within a /24 subnet. if notation `x.x.x.x/x` is used there is posibility to set host/netmask.

### Set default pool

```shell
set vpn l2tp remote-access default-pool <POOL-NAME>
```

use this command to define default address pool name.

### Specifies gateway

```shell
set vpn l2tp remote-access gateway-address <gateway>
```

Specifies sinlge \<gateway\> IP address to be used as local address of PPP interfaces

### Specifies client without ip pool

``` shell
set vpn l2tp remote-access authentication <username> static-ip <ip-address>
```

User with static ip will not given address by ip pool
