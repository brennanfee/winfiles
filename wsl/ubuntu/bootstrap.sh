#!/usr/bin/env bash
# Bash "strict" mode
set -euo pipefail
IFS=$'\n\t'

# This script is intended to be run as the very first thing once starting up a new Ubuntu
# shell.  It has been tested with the Ubuntu 18.04 shell available in the Windows Store.

# After this script five steps should be taken:
# 1.  Restart the shell (close down and reload)
# 2.  Manually install your SSH keys
# 3.  Run the ansible script in the same folder as this script (tbd ansible cmd here)
# 4.  Pull your dotfiles using the SSH keys, setup using rcup
# 5.  Restart the shell (close down and reload) - everything should now be set up

# Must be run as sudo/root
if [[ "$EUID" -ne 0 ]]; then
    echo "This script must be run as root."
    exit
fi

# First fully upgrade
apt update
apt upgrade -y

# Write out the /etc/wsl.conf file if it doesn't exist
if [[ ! -f "/etc/wsl.conf" ]]; then
    echo -e "[automount]\noptions = \"metadata,umask=22,fmask=11\"" >/etc/wsl.conf
fi

# Install ansible
apt install -y ansible python3-winrm ansible-lint
