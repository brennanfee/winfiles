# winfiles

My ['dotfiles'](https://dotfiles.github.io) and configuration scripts for Windows

## Purpose

### A 'mostly' Automated Windows Setup

Unlike better operating systems (ahem... Linux), Windows can't fully be configured automatically.  Well, simple installations might be able to but full desktop configurations with disparate applications and settings is nearly impossible to achieve.

This is my attempt at making the setup of my machines as quick and "automatic" as possible.  There are still a number of manual steps I have to take and even the "automatic" process is a multi-step affair.  But, I can usually get a brand new Windows installation up and running fairly quickly and **consistently** with this setup.

### Not just installation but config as well

This repository also contains my personal settings and configurations much in the same way that `dotfiles` are used on Linux.  In fact, a sub-module of this repository is in fact my Linux\Mac `dotfiles` so that I can share some files between all systems.

## Installation Overview

Full installation steps, including the manual portions can be found in [Installation Steps](installation-steps.md).

In summary, the broad steps (particularly the automated parts) are as follows:

1. Install Windows & Run Updates
2. Open PowerShell as an Administrator
    * Run: `Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -Uri 'https://git.io/fjBQX').Content)`
    * Or: `iex ((iwr -UseBasicParsing -Uri 'https://git.io/fjBQX').Content)`
3. Once complete run: `.\01-setup-profile.ps1'
4. Once complete, close PowerShell and re-open as Administrator.
5. Run: `.\02-bootstrap.ps1`
    * As an option you can pass an install "type" like so `.\02-bootstrap.ps1 -InstallType "home"`.  "Home" is the default with "work" and "gaming" as other options.  The primary difference between the install types are what applications and settings are being used.
6. Reboot.
7. Run: `.\03-cleanup.ps1`

At that point the automated portions are complete.

### Option Without Running Web Script

The initial script run in Step 2 above will initialize Git and clone this repository.  If instead it is preferred to do that manually, you can.  Afterward, you can start at Step 3 above from within the folder for this repository.

## Applications

I install as many applications as I can automatically using two different install managers.  [AppGet](https://appget.net/) and [Scoop](https://scoop.sh/).

### AppGet

AppGet is generally the first source to install an application.  If both Scoop and AppGet offer the same application, AppGet is used (with a few exceptions).  It manages updates to applications well and can even handle applications that self-update (such as Google Chrome or Firefox).

### Scoop

Scoop is best for managing command-line applications or tools where multiple versions may be needed (such as programming languages like Python, Ruby).  While the focus is on command-line tools, when AppGet doesn't offer an application Scoop will still be used.

## License

[MIT](license) © 2019 [Brennan Fee](https://github.com/brennanfee)
