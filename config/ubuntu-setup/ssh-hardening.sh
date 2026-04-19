#!/bin/bash
# Scope: SSH hardening
# Usage: Edit ALLOW_USER below before running. Requires key-based auth already set up.

set -e

ALLOW_USER="chusnul"   # <-- ganti dengan username kamu

SSHD_CONFIG="/etc/ssh/sshd_config"

cp "$SSHD_CONFIG" "${SSHD_CONFIG}.bak.$(date +%F)"

sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' "$SSHD_CONFIG"
sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' "$SSHD_CONFIG"
sed -i 's/^#\?PubkeyAuthentication.*/PubkeyAuthentication yes/' "$SSHD_CONFIG"
sed -i 's/^#\?MaxAuthTries.*/MaxAuthTries 3/' "$SSHD_CONFIG"
sed -i 's/^#\?LoginGraceTime.*/LoginGraceTime 30/' "$SSHD_CONFIG"
sed -i 's/^#\?Protocol.*/Protocol 2/' "$SSHD_CONFIG"

# Remove existing AllowUsers line if any, then append
sed -i '/^AllowUsers/d' "$SSHD_CONFIG"
echo "AllowUsers $ALLOW_USER" >> "$SSHD_CONFIG"

sshd -t && systemctl restart ssh
echo "Done: SSH hardened. Backup saved at ${SSHD_CONFIG}.bak.$(date +%F)."
