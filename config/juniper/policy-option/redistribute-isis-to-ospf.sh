# create policy statement
edit policy-options policy-statement redistribute-isis-to-ospf

# anything from protocol isis will accept
set from protocol isis
set then accept
