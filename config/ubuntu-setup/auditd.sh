#!/bin/bash
# Scope: Audit logging (auditd)
# Usage: Run once. Tracks changes to critical system files.

set -e

apt install -y auditd audispd-plugins

cat > /etc/audit/rules.d/hardening.rules << 'EOF'
# Monitor privilege escalation
-w /etc/sudoers -p wa -k sudoers
-w /etc/sudoers.d/ -p wa -k sudoers

# Monitor user/password files
-w /etc/passwd -p wa -k passwd
-w /etc/shadow -p wa -k shadow
-w /etc/group -p wa -k group

# Monitor SSH config
-w /etc/ssh/sshd_config -p wa -k sshd_config

# Monitor cron
-w /etc/cron.d/ -p wa -k cron
-w /etc/crontab -p wa -k cron
-w /var/spool/cron/ -p wa -k cron

# Monitor login config
-w /etc/login.defs -p wa -k login
-w /etc/pam.d/ -p wa -k pam

# Monitor startup scripts
-w /etc/init.d/ -p wa -k init
-w /etc/systemd/ -p wa -k systemd
EOF

augenrules --load
systemctl enable --now auditd
echo "Done: auditd enabled with hardening rules."
