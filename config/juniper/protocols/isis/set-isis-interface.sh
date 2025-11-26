# interface address iso must be configured

set protocols isis interface ge-0/0/0

# using isis level 1 only
set protocols isis interface ge-0/0/0 level 2 disable

# using isis level 2 only
set protocols isis interface ge-0/0/0 level 1 disable
