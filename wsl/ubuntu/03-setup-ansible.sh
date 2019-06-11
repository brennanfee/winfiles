#!/usr/bin/env bash
# Bash "strict" mode
set -euo pipefail
IFS=$'\n\t'

# These setup scripts are intended to be run as the very first things once
# starting up a new Ubuntu WSL shell.  It has been tested with the Ubuntu 18.04
# and the Ubuntu shell (no version) shells available in the Windows Store.

# After running this script the following steps should be taken:
# 1.  Tweak the ~/.rcrc if needed, run `mkrc -o "$HOME/.rcrc"` if desired
# 2.  Run `rcup`
# 3.  Close and reload the shell
# 4.  Run the ansible script in this same folder.
#    * Command:  (tbd ansible cmd here)
# 5.  Run `asdf install` - this will take very LONG time
# 6.  Close and reload the shell
# 7.  That's it, everything should now be fully configured
