# winfiles

My ['dotfiles'](https://dotfiles.github.io) and configuration scripts for Windows

## Purpose

### A 'mostly' Automated Windows Setup

Unlike better operating systems (ahem... Linux), Windows can't fully be configured automatically.  Well, simple installations might be able to but full desktop configurations with disparate applications and settings is nearly impossible to achieve.

This is my attempt at making the setup of my machines as quick and "automatic" as possible.  There are still a number of manual steps I have to take and even the "automatic" process is a multi-step affair.  But, I can usually get a brand new Windows installation up and running fairly quickly and **consistently** with this setup.

### Not just installation but config as well

This repository also contains my personal settings and configurations much in the same way that `dotfiles` are used on Linux.  In fact, a sub-module of this repository is in fact my `dotfiles` so that I can share some files between all systems.

## Installation Overview



# OLD

## Installation Steps

NOTE: These steps are intended to follow a [BoxStarter](http://boxstarter.org) install found in my [provision-windows](https://github.com/brennanfee/provision-windows) repository.  In truth the only prerequisites for the following to succeed are that [Chocolatey](https://chocolatey.org) and [Git](https://git-scm.com) are already installed.

1. Use Git to clone the repository into a "winFiles" folder in your home folder (typically C:\Users\<username>).
    * Given that the repo has a submodule you will need to execute `git submodule update --init --recursive` after clone.
1. Launch PowerShell as an administrator.  Run the [setup-powershell.ps1](setup-powershell.ps1) script.  This initializes a PowerShell profile and installs any settings\files that require administrator privileges.
1. Launch PowerShell again, this time not as administrator.  Run the [setup.ps1](setup.ps1) script. This installs most of the settings, files, and applications that are user account specific.
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
