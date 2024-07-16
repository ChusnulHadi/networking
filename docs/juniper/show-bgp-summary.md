# Show BGP Summary

Display BGP Summary Information

```shell
> show bgp summary
```

Assumming we have 3 BGP Instances like:

- 172.16.0.1 AS 100
- 172.17.0.1 AS 200
- 172.18.0.1 AS 300

Output:

```shell
Groups: 3 Peers: 3 Down peers: 3
Table          Tot Paths  Act Paths Suppressed    History Damp State    Pending
inet.0               
                       0          0          0          0          0          0
Peer                     AS      InPkt     OutPkt    OutQ   Flaps Last Up/Dwn State|#Active/Received/Accepted/Damped...
172.16.0.1      100          0          0       0       0    22:51:18 Idle  
172.17.0.1      200          0          0       0       0    22:51:18 Idle  
172.18.0.1      300          0          0       0       0    22:51:18 Idle 
```
