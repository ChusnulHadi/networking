#!/bin/bash
# Scope: Bash history with timestamps + hardening
# Usage: Run once. Applies to all existing and new users via /etc/profile.d/

set -e

# Global config via /etc/profile.d (applies to all users)
cat > /etc/profile.d/bash-history.sh << 'EOF'
# Bash history with timestamps
export HISTTIMEFORMAT="%F %T "

# Increase history size
export HISTSIZE=10000
export HISTFILESIZE=20000

# Avoid duplicate and blank lines
export HISTCONTROL=ignoredups:erasedups

# Append instead of overwrite on shell exit
shopt -s histappend

# Write to history after every command (real-time)
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
EOF

# Apply also to root
ROOT_BASHRC="/root/.bashrc"
MARKER="# bash-history-timestamp"

if ! grep -q "$MARKER" "$ROOT_BASHRC" 2>/dev/null; then
    cat >> "$ROOT_BASHRC" << 'EOF'

# bash-history-timestamp
export HISTTIMEFORMAT="%F %T "
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
EOF
fi

echo "Done: bash history timestamps enabled for all users."
echo "Re-login or run: source /etc/profile.d/bash-history.sh"
