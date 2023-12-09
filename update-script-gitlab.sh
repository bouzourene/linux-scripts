#!/bin/bash

# Get path to the script repo
SCRIPTPATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Execute generic update script
source ${SCRIPTPATH}/update-script.sh

# If reboot was not needed, restart gitlab
gitlab-ctl restart
