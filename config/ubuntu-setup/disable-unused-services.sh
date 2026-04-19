#!/bin/bash
# Scope: Minimize Ubuntu server — disable/remove everything non-essential
# Goal: Smallest RAM footprint for headless server/VM
# Usage: Run as root. Review KEEP_SNAP and KEEP_LXD flags below.

set -e

KEEP_SNAP=false   # set true jika butuh snap packages
KEEP_LXD=false    # set true jika butuh LXD containers

# ─── Helper ───────────────────────────────────────────────────────────────────

svc_exists() {
    systemctl list-unit-files "$1.service" --no-legend | grep -q "$1"
}

disable_svc() {
    local svc="$1"
    local reason="$2"
    if svc_exists "$svc"; then
        echo "  [disable+mask] $svc — $reason"
        systemctl disable --now "$svc" 2>/dev/null || true
        systemctl mask "$svc" 2>/dev/null || true
    fi
}

purge_pkg() {
    local pkg="$1"
    if dpkg -l "$pkg" &>/dev/null; then
        echo "  [purge] $pkg"
        apt purge -y "$pkg" 2>/dev/null || true
    fi
}

# ─── Before ───────────────────────────────────────────────────────────────────

echo "=== RAM before ==="
free -h
echo ""

# ─── 1. Snap (biggest RAM offender, 50-150MB) ─────────────────────────────────

if [ "$KEEP_SNAP" = false ]; then
    echo "[snap] Removing snapd..."
    systemctl stop snapd.service snapd.socket snapd.seeded.service 2>/dev/null || true
    systemctl disable snapd.service snapd.socket snapd.seeded.service 2>/dev/null || true

    # Remove all snap packages first
    snap list 2>/dev/null | awk 'NR>1 {print $1}' | xargs -r snap remove --purge 2>/dev/null || true

    apt purge -y snapd 2>/dev/null || true
    rm -rf /snap /var/snap /var/lib/snapd /var/cache/snapd ~/snap

    # Prevent apt from reinstalling snapd
    cat > /etc/apt/preferences.d/no-snapd << 'EOF'
Package: snapd
Pin: release a=*
Pin-Priority: -1
EOF
    echo "  [done] snapd purged and pinned to never reinstall."
fi

# ─── 2. Desktop / GUI remnants ────────────────────────────────────────────────

echo "[desktop] Disabling desktop/GUI services..."
disable_svc accounts-daemon     "AccountsService — GNOME user management"
disable_svc colord               "color management daemon"
disable_svc geoclue              "geolocation service"
disable_svc packagekit           "software center backend"
disable_svc speech-dispatcher    "text-to-speech"
disable_svc switcheroo-control   "GPU switching"
disable_svc udisks2              "disk automount daemon"
disable_svc upower               "power management (laptop)"
disable_svc thermald             "thermal management (laptop/desktop)"

purge_pkg packagekit
purge_pkg colord
purge_pkg geoclue-2.0

# ─── 3. Printing ──────────────────────────────────────────────────────────────

echo "[printing] Disabling print services..."
disable_svc cups          "printing"
disable_svc cups-browsed  "network printer discovery"
purge_pkg cups
purge_pkg cups-browsed
purge_pkg printer-driver-postscript-hp

# ─── 4. Network junk ─────────────────────────────────────────────────────────

echo "[network] Disabling unnecessary network services..."
disable_svc avahi-daemon   "mDNS/zeroconf — not needed on server"
disable_svc ModemManager   "mobile broadband"
disable_svc wpa_supplicant "WiFi — not needed on wired server"
disable_svc bluetooth      "bluetooth"

purge_pkg avahi-daemon
purge_pkg avahi-utils
purge_pkg modemmanager
purge_pkg wpasupplicant
purge_pkg bluez

# ─── 5. Firmware update daemon ────────────────────────────────────────────────

echo "[firmware] Disabling fwupd..."
disable_svc fwupd          "firmware update daemon — run manually when needed"
disable_svc fwupd-refresh  "firmware refresh timer"
purge_pkg fwupd

# ─── 6. Crash reporting ───────────────────────────────────────────────────────

echo "[crash-report] Disabling crash reporting..."
disable_svc whoopsie  "Ubuntu crash reporting"
disable_svc apport    "crash report handler"
purge_pkg whoopsie
purge_pkg apport

# ─── 7. Storage daemons (VM/cloud — no SAN/iSCSI) ────────────────────────────

echo "[storage] Disabling storage daemons not needed on VM..."
disable_svc multipathd  "multipath I/O — only needed for SAN"
disable_svc iscsid      "iSCSI initiator — only needed for SAN"
disable_svc open-iscsi  "iSCSI — only needed for SAN"

purge_pkg multipath-tools
purge_pkg open-iscsi

# ─── 8. LXD ──────────────────────────────────────────────────────────────────

if [ "$KEEP_LXD" = false ]; then
    echo "[lxd] Disabling LXD..."
    disable_svc lxd         "LXD container daemon"
    disable_svc lxd-agent   "LXD agent"
    purge_pkg lxd
    purge_pkg lxd-agent
fi

# ─── 9. Misc system daemons ───────────────────────────────────────────────────

echo "[misc] Disabling misc daemons..."
disable_svc irqbalance      "IRQ balancing — only useful on multi-socket NUMA servers"
disable_svc plymouth        "boot splash screen"
disable_svc plymouth-quit   "boot splash screen"

purge_pkg plymouth
purge_pkg irqbalance

# ─── 10. Trim unused packages ─────────────────────────────────────────────────

echo "[cleanup] Removing orphaned packages..."
apt autoremove -y --purge
apt autoclean -y

# ─── After ────────────────────────────────────────────────────────────────────

echo ""
echo "=== RAM after ==="
free -h
echo ""
echo "=== Running services ==="
systemctl list-units --type=service --state=running --no-pager
echo ""
echo "Done: Ubuntu minimized."
