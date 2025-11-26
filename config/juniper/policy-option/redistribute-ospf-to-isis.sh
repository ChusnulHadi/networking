# create policy statement
edit policy-options policy-statement redistribute-ospf-to-isis

# anything from protocol isis will accept
set from protocol isis
set then accept
