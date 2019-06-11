#!/usr/bin/env bash
# Bash "strict" mode
set -euo pipefail
IFS=$'\n\t'

# These setup scripts are intended to be run as the very first things once
# starting up a new Ubuntu WSL shell.  It has been tested with the Ubuntu 18.04
# and the Ubuntu shell (no version) shells available in the Windows Store.

# After running this script, run the 03-setup-ansible.sh script found in the
# same directory as this file.

# Install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"
cd -

# Source asdf and the completions
source "$HOME/.asdf/asdf.sh"
source "$HOME/.asdf/completions/asdf.bash"
echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc

# Setup python
asdf plugin-add python
asdf install python 3.7.3
asdf global python 3.7.3

# Update pip
python3 -m pip install --user --upgrade pip

# Install pipx
python3 -m pip install --user pipx
python3 -m userpath append ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"

# Install ansible
pipx install ansible
pipx install ansible-lint

# Setup the SSH keys
driveNumber=$(ls -1 /mnt | wc -l)

if [[ "$driveNumber" -eq "1" ]]; then
  cp /mnt/c/profile/cloud/keys/ssh/ssh-keys.7z ~/
else
  cp /mnt/d/profile/cloud/keys/ssh/ssh-keys.7z ~/
fi

mkdir "$HOME/.ssh"
7z e ssh-keys.7z -o"$HOME/.ssh"
rmdir "$HOME/.ssh/ssh-keys"
chmod +x "$HOME/.ssh/setPerms.sh"
$HOME/.ssh/setPerms.sh
rm "$HOME/ssh-keys.7z"

# Pull the dotfiles
git clone git@github.com:brennanfee/dotfiles.git "$HOME/.dotfiles"
git clone git@github.com:brennanfee/dotfiles-private.git "$HOME/.dotfiles-private"

$HOME/.dotfiles/setup.sh

cd -

echo ""
echo "Edit the ~/.rcrc file if needed, then run `rcup`"
echo "(Optional) Add the ~/.rcrc file to dotfiles with `mkrc -o "$HOME/.rcrc"`"
echo ""
echo "Once done close the shell and re-open then run 03-setup-ansible.sh"
echo ""
