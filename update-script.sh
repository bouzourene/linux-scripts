#!/bin/bash

echo "Starting system update..."

if [ "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]; then

	# Debian system
	echo "Debian based system, using apt..."

	apt-get update
	apt-get upgrade -y
	apt-get autoremove -y

	if [ -f /var/run/reboot-required ]; then
		echo "Rebbot needed."
		reboot
	else
		echo "No reboot needed."
	fi

elif [ "$(grep -Ei 'fedora|redhat' /etc/*release)" ]; then

	# RHEL system
	echo "RHEL based system, using dnf..."

	dnf upgrade -y

	LAST_KERNEL=$(rpm -q --last kernel | perl -pe 's/^kernel-(\S+).*/$1/' | head -1)
	CURRENT_KERNEL=$(uname -r)
	if [[ ! $LAST_KERNEL = $CURRENT_KERNEL ]]; then
		echo "Rebbot needed."
		reboot
	else
		echo "No reboot needed."
	fi

else

	# Unknown system
	echo "System is unkown, not updating."

fi

echo "End of update script"
