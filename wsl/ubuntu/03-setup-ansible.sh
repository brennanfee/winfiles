#!/usr/bin/env bash
# Bash "strict" mode
set -euo pipefail
IFS=$'\n\t'

# These setup scripts are intended to be run as the very first things once
# starting up a new Ubuntu WSL shell.  It has been tested with the Ubuntu 18.04
# and the Ubuntu shell (no version) shells available in the Windows Store.

# After running this script the following steps should be taken:
# 1.  Run `asdf install` - this will take very LONG time
# 2.  Close and reload the shell

ANSIBLE_CONFIG=./ansible.cfg bash -c \
'ansible-playbook -b -K main.yml -e ansible_python_interpreter=/usr/bin/python3'

echo ""
echo "You can now run `asdf install`, that will take a LONG time."
echo "Once complete, close and reload the shell and setup is complete."
echo ""
