# Installation Steps

This document covers the entire process (both automatic and manual) that I follow when setting up a new Windows machine.

## Note on Profile location

In many steps below we refer to the "$profile" directory.  This will live in either C:\profile or D:\profile depending on whether the machine has one hard drive or more than one.

## Step 1: Install Windows & Run Updates

This is a manual step.  During installation, Windows should be connected to your Microsoft account. Reboot as needed and run updates as many times as necessary in order to be "fully" updated.

## Step 2: Run the 00-pull Script

This script will initialize Git and clone this repository.

1. Open PowerShell as an Administrator
2. Run `iex ((iwr -UseBasicParsing -Uri 'https://git.io/fjBQX').Content)`

If desired, instead of relying on the PowerShell aliases iex and iwr, you can run the following instead:

`Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -Uri 'https://git.io/fjBQX').Content)`

Lastly, if it is preferred to do this step manually, you can.  Some people feel it is a security risk to run scripts from the web and as such want to avoid that practice.  In that case, just install Git and pull the repo to a local directory.  Afterward, you can start with Step 3 below from within the folder for this repository.

## Step 3: Run the 01-setup-profile Script

1. If not in the winfiles directory navigate to $profile\winfiles.
2. Run `.\01-setup-profile.ps1`
3. Close PowerShell.

## Step 4: Run the 02-bootstrap Script

1. Open PowerShell as an Administrator
2. If not in the winfiles directory navigate to $profile\winfiles.
3. Run `.\02-bootstrap.ps1`
4. Reboot

This step will take a while.  It sets up a bunch of registry settings as well as installs\removes Windows modules and default applications.  Be sure to reboot once completed as that will "complete" many of the removals and installations.

## Step 5: Run the 03-app-installs Script

1. Open PowerShell as an Administrator
2. If not in the winfiles directory navigate to $profile\winfiles.
3. Run `.\03-app-installs.ps1`
4. Reboot (again)

This step will take a **LONG** time.  During this step, be on the lookout for the occasional dialog box during application installations.  I have tried my best to ensure that none of these installations will be blocking or have prompts, but it is a good idea to be on the lookout and check the machine every now and again.

Again, the reboot may be necessary for some of the applications installed, so don't skip that step.

## Step 5b (OPTIONAL): Run the optional-install-games Script

This is an **optional** step and should only be run on machines for gaming.  This installs a bunch of game managers like BattleNet, Steam, GOG Galaxy, etc.

1. Open PowerShell as an Administrator
2. If not in the winfiles directory navigate to $profile\winfiles.
3. Run `.\optional-install-games.ps1`
4. Reboot (yes, again)

NOTE: These installations do have prompts so pay attention during the script run in order to get the apps installed\configured.

If you are performing this step at a later time it is safe to run the `04-cleanup.ps1` script after it another time to clean things up.

## Step 6: Run the 04-cleanup Script

1. Open PowerShell as an Administrator
2. If not in the winfiles directory navigate to $profile\winfiles.
3. Run `.\04-cleanup.ps1`
4. Close PowerShell.

This should conclude the "base" installation of the system.  It includes the custom settings ('winfiles' a.k.a. 'dotfiles'), a custom Windows configuration, as well as a collection of applications I use on nearly every machine.

The manual steps finish any installations\configurations for any apps that require prompts or other manual steps.

## Step 7: Manual Configurations

There are a few manual configurations that must be performed before continuing.

1. Point some Windows "special folders" to the profile location folders.  The folders to redirect are:
    - Desktop
    - Downloads
    - Music
    - Pictures
    - Videos
    - NOTE: DO NOT redirect 'My Documents', my profile 'documents' folder holds regular files and the 'My Documents' folders gets filled with a bunch of application garbage.
2. Log into Mega and configure Mega Sync (the most important folder to sync is the \$profile\cloud).  I commonly also sync my music folder ($profile\music) if the hard drives are large enough.
3. I like to configure "Quick Access" in a specific order.  So, open File Explorer and add\remove paths to the "Quick Access" menu as follows:
    - profle ($profile)
    - source ($profile\source)
    - downloads ($profile\downloads)
    - cloud ($profile\cloud)
    - documents ($profile\documents)
    - music ($profile\music)
    - videos ($profile\videos)
    - pictures ($profile\pictures)
    - home (usually C:\users\<your username here>)

## Step 8: Manual Installations

### Install Store Applications

Start by loading the "Microsoft Store" app and run all updates.

Use the "Microsoft Store" app to install the following (which can usually be seen in the 'Ready To Install' section):

- Okular
- Windows Terminal
- X410
- Ubuntu
- Debian
- Dolby Access
- Microsoft Remote Desktop
- Netflix
- Hulu
- Twitter
- NPR One
- Alexa

After this step, you should take a moment to run both Ubuntu and Debian and perform the initial configurations for those two systems.

**NOTE**: What about Arch for WSL, looks like it was removed from the store.

For games:

- Microsoft Minesweeper
- Microsoft Sudoku
- Microsoft Solitaire Collection
- Microsoft Ultimate Word Games

### Install Applications With Prompts Or Config

The following applications are available from AppGet or Scoop but bring up blocking dialogs or require other immediate configuration to complete.  So they must be manually installed here.  These all should be done within an Administrator PowerShell.

1. `appget install rainmeter`
2. `appget install pia`

And finally, this one must be run from a non-Administrator PowerShell.

`appget install spotify`

### Install Applications Not Available In AppGet Or Scoop

Q: Why are most of these things in the "cloud" synced folder rather than the winfiles folder?

A: Because I may not have legal right to re-distribute those files or they are sensitive (like my settings).

#### Directory Opus

1. Directory Opus.  The install can be found in `$profile\cloud\installs\windows\DirectoryOpus\`.
2. After install, the license can be loaded from `$profile\cloud\appSettings\DirectoryOpus`
3. Lastly, the configuration can be restored from the same directory in step #2.

For those that want to obtain Directory Opus you can find the install and buy a license here: https://www.gpsoft.com.au

It is one of the few licensed\proprietary applications that I use and it is **so good** that I truly can't use Windows without it.  It is a full replacement for the Windows File Explorer.

#### Fonts

There are some fonts which need to be manually installed in the following locations:

1. `$profile\cloud\installs\windows\fonts\google`
2. `$profile\cloud\installs\windows\fonts\other`

Just right-click on all of the files and select "Install".

#### Visual Studio & Docker

On development machines, now is the time to install Docker and Visual Studio.

1. Docker: `appget install docker-community`
1. Visual Studio: `$profile\cloud\installs\windows\VisualStudio\`

## Step 8: WSL Environment Configurations

TBD
