# Qualified Next hop
# This will make route failover in case of primary link failure

set routing-options static route 1.1.1.1/32 next-hop 10.10.0.1 # Primary route
# Default static preference is 5
set routing-options static route 1.1.1.1/32 qualified-next-hop 10.10.1.2 preference 10
