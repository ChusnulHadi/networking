#!/bin/bash
# Scope: Kernel hardening via sysctl
# Usage: Run once. Adjust ip_forward if server is a router or runs VPN.

set -e

cat > /etc/sysctl.d/99-hardening.conf << 'EOF'
# Disable IP forwarding (set to 1 if server acts as router/VPN gateway)
net.ipv4.ip_forward = 0

# SYN flood protection
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_max_syn_backlog = 2048

# Disable ICMP redirects
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0

# Ignore broadcast pings
net.ipv4.icmp_echo_ignore_broadcasts = 1

# Log suspicious/spoofed packets
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1

# Protect against time-wait assassination
net.ipv4.tcp_rfc1337 = 1

# Disable source routing
net.ipv4.conf.all.accept_source_route = 0
net.ipv6.conf.all.accept_source_route = 0
EOF

sysctl -p /etc/sysctl.d/99-hardening.conf
echo "Done: kernel hardening applied."
