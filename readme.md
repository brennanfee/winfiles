# Winfiles

My ['dotfiles'](https://dotfiles.github.io) and configuration scripts for Windows.

## Purpose

### A 'mostly' Automated Windows Setup

Unlike better operating systems (ahem... Linux), Windows can't fully be configured automatically very easily (largely due to the need for multiple reboots). Well, in fairness, simple installations might be able to but full desktop configurations with disparate applications and settings is nearly impossible to achieve.  Registry values, shell and environment variables, Windows feature installations, and application installs or configurations all might require the restarting of PowerShell or even a reboot to be recognized.

This is my attempt at making the setup of my machines as quick and "automatic" as possible. There are still a number of individual and ordered steps I have to take, but each step is mostly just executing a single script and then waiting.  Still, I can usually get a brand new Windows installation up and running fairly quickly and **consistently** with this setup.

### Not just installation but config as well

This repository also contains my personal settings and configurations much in the same way that `dotfiles` are used on Linux. In fact, a sub-module of this repository is in fact my Linux\Mac `dotfiles` so that I can share some files between all systems.

## System Type

During installation, the scripts will prompt for what "system type" the installation is for. I offer two options, "Home" and "Work", which should largely be self-explanatory.  The primary difference between the two types are the mix of applications installed and which settings are being used.

## Installation Overview

Full installation steps, including the manual portions can be found in
[Installation Steps](installation-steps.md).

In summary, the broad steps (particularly the automated parts) are as follows:

1. Install Windows & Run Updates (rebooting as necessary)
2. Open PowerShell as an Administrator
   - Run:
     `Set-ExecutionPolicy Bypass -Scope Process -Force -ErrorAction Ignore`
   - Run: `iex ((iwr -UseBasicParsing -Uri 'https://git.io/fjBQX').Content)`
3. Once complete, close PowerShell and re-open as Administrator
4. Once complete run: `.\01-setup-profile.ps1'
5. Once complete, close PowerShell and re-open as Administrator
6. Run: `.\02-bootstrap.ps1`, this will take a while
7. **Reboot.** Once up, re-open PowerShell as Administrator
8. Run: `.\03-app-installs.ps1`, this will take a **LONG** time
9. (Optional) Also run any or all of the "optional-install" scripts found at the root of the project.  These install extra applications for the given use case (currently gaming and development).
10. **Reboot (again).** Re-open PowerShell as Administrator
11. Run: `.\04-cleanup.ps1`

At that point the automated portions are complete. For more details and further (manual
and optional) instructions, see [Installation Steps](installation-steps.md).

### Option Without Running Web Script

The initial script run in Step 2 above will initialize Git and clone this repository. If
instead it is preferred to do that manually, you can. Afterward, you can start at Step 3
above from within the folder for this repository.

## WinGet (the Windows Package Manager)

I used to use [Chocolatey](https://chocolatey.org) but have recently moved to [WinGet](https://docs.microsoft.com/en-us/windows/package-manager/winget/).  WinGet is the "official" package manager supported by Microsoft.  It is still v1 and such a bit limited but works well enough for my needs.

## License

[MIT](license) © 2020 [Brennan Fee](https://github.com/brennanfee)
