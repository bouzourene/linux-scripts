#!/bin/bash

# Remove no subsucription message
PROXMOXLIB="/usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js"
sed -Ezi "s/(Ext.Msg.show\(\{\s+title: gettext\('No valid sub)/void\(\{ \/\/\1/g" $PROXMOXLIB
systemctl restart pveproxy.service

# Replace proxmox enterprise repo
rm -f /etc/apt/sources.list.d/pve-enterprise.list
NOSUBREPO="deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription"
echo $NOSUBREPO > /etc/apt/sources.list.d/pve-no-subscription.list
apt-get update
