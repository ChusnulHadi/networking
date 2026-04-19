#!/bin/bash
# Scope: AppArmor enforcement
# Usage: Run once. Enforces all loaded profiles.

set -e

apt install -y apparmor apparmor-utils apparmor-profiles

systemctl enable --now apparmor

# Set all profiles to enforce mode
aa-enforce /etc/apparmor.d/* 2>/dev/null || true

echo "AppArmor status:"
aa-status --summary
echo "Done: AppArmor enforcing."
