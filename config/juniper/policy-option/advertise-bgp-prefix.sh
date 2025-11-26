# advertise prefix from bgp neighbor peer
edit policy-options policy-statement advertise-bgp-prefix-in

set term allow-all from route-filter 0.0.0.0/0 prefix-filter-range /8-/24
set term allow-all then accept
set then reject


# advertise local bgp prefix to neighbor peer
edit policy-options policy-statement advertise-local-bgp-prefix-to-neighbor-peer
set term adv-local from protocol bgp
set term adv-local from route-filter 192.168.0.0/24 exact
set term adv-local then accept
set then reject
