# RUN IN CONFIG MODE

# Add VLAN on Interface Unit
# Assuming we will add vlan 100 to interface ge-1/0/0 unit 1

# Make sure interface ge-1/0/0 is vlan tagging
# Ignore if interface already configured as vlan-tagging
set interfaces ge-1/0/0 vlan-tagging

# Add VLAN on Interface Unit
set interfaces ge-1/0/0 unit 1 vlan-id 100