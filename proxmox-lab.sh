#!/bin/bash

# Remove no subsucription message
# ===============================

PROXMOXLIB="/usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js"

if grep -q "//Ext.Msg.show({" $PROXMOXLIB; then
	echo "proxmoxlib.js -> no patching needed"
else
	echo "proxmoxlib.js -> patching needed"
	sed -Ezi "s/(Ext.Msg.show\(\{\s+title: gettext\('No valid sub)/void\(\{ \/\/\1/g" $PROXMOXLIB
	systemctl restart pveproxy.service
fi

# Replace proxmox enterprise repo
# ===============================

rm -f /etc/apt/sources.list.d/pve-enterprise.list
rm -f /etc/apt/sources.list.d/ceph.list

NOSUBREPO="deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription"
echo $NOSUBREPO > /etc/apt/sources.list.d/pve-no-subscription.list
apt-get update
