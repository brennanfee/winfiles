# winfiles

My 'dotfiles' for Windows

## Installation Steps

1. Use Git to clone the repository into a "winFiles" folder in your home folder.
    * Given that the repo has a submodule you will need to execute `git submodule update --init --recursive` after clone.
1. Launch PowerShell as an administrator.  Run `setup-powershell.ps1` script.
1. Launch PowerShell again, this time not as administrator.  Run the `setup.ps1` script.
1. If the machine is brand new and things have not been installed you should run the `install-apps.ps1` script.
1. If the machine is brand new and is a developer machine also run the `install-apps-dev.ps1` script.
1. Close the console.
    * A reboot will likely be needed given the system settings that were changed in the above scripts.

## Applications

For windows I have some things installed by Chocolatey and other things I install automatically outside Chocolatey or even manually (when something can't or shouldn't be automated).  The 'install-apps.ps1' script above takes care of the Chocolatey install along with any installs that could be automated (outside Chocolatey).

The reasoning is that some apps update themselves (like Chrome) and so using Chocolatey to install them is more of a hassle as they show up as needing updates even though they have self-updated.

Below are the (current) list of applications in each category.

### Chocolatey Apps

TBD

### Automatically installed outside Chocolatey

TBD

### Manually installed

TBD

Fonts (nerd fonts)
Fonts (noto - from google)
