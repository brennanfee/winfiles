# winfiles

My 'dotfiles' for Windows

## Installation Steps

NOTE: These steps are intended to follow a [BoxStarter](https://boxstarter.org) install found in my [provision-windows](https://github.com/brennanfee/provision-windows) repository.  In truth the only pre-reqs for the following to succeed are that [Chocolatey](https://chocolatey.org) and [Git](https://git-scm.com) are already installed.

1. Use Git to clone the repository into a "winFiles" folder in your home folder (typically C:\Users\<username>).
    * Given that the repo has a submodule you will need to execute `git submodule update --init --recursive` after clone.
1. Launch PowerShell as an administrator.  Run `setup-powershell.ps1` script.  This initializes a PowerShell profile and installs any settings/files that require administrator privileges.
1. Launch PowerShell again, this time not as administrator.  Run the `setup.ps1` script. This installs most of the settings and files that are user account specific.
1. If the machine is brand new and things have not been installed you should run the `install-apps.ps1` script.
1. If the machine is brand new and is a developer machine also run the `install-apps-dev.ps1` script.
1. Close the console.
    * A reboot will likely be needed given the system settings that were changed in the above scripts.

## Applications

For windows I install as much as I possibly can using Chocolatey.  However, some things either can not be installed with Chocolatey or are better installed manually.  The 'install-apps.ps1' script above takes care of all of the Chocolatey installs (with install-apps-dev.ps1 for development machines).

To view which apps are installed you can view the chocolatey-packages.config and chocolatey-packages-dev.config files.

Below are the list of applications that I install manually along with the reason it is manual.

### Manually Installed Apps

TBD

### Manually Installed Apps (Developer Machines Only)

TBD

### Fonts (also manually installed)

NOTE: At present, fonts are installed manually until a better mechanism for managing fonts comes alone.

TBD

Fonts (nerd fonts)
Fonts (noto - from google)
