set firewall name OUTSIDE-LOCAL rule 40 action 'accept'
set firewall name OUTSIDE-LOCAL rule 40 protocol 'esp'

set firewall name OUTSIDE-LOCAL rule 41 action 'accept'
set firewall name OUTSIDE-LOCAL rule 41 destination port '500'
set firewall name OUTSIDE-LOCAL rule 41 protocol 'udp'

set firewall name OUTSIDE-LOCAL rule 42 action 'accept'
set firewall name OUTSIDE-LOCAL rule 42 destination port '4500'
set firewall name OUTSIDE-LOCAL rule 42 protocol 'udp'

set firewall name OUTSIDE-LOCAL rule 43 action 'accept'
set firewall name OUTSIDE-LOCAL rule 43 destination port '1701'
set firewall name OUTSIDE-LOCAL rule 43 ipsec 'match-ipsec'
set firewall name OUTSIDE-LOCAL rule 43 protocol 'udp'
