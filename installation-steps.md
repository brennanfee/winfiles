# Installation Steps

This document covers the entire process (both automatic and manual) that I follow when
setting up a new Windows machine.

## Note on Profile location

In many steps below we refer to the "\$profile" directory. This will live in either
C:\profile or D:\profile depending on whether the machine has one hard drive or more
than one.

## Step 1: Install Windows & Run Updates

This is a manual step. During installation, Windows should be connected to your
Microsoft account. Reboot as needed and run updates as many times as necessary in order
to be "fully" updated.

## Step 2: Run the 00-pull Script

This script will initialize Git and clone this repository.

1. Open PowerShell as an Administrator
2. Run `iex ((iwr -UseBasicParsing -Uri 'https://git.io/fjBQX').Content)`
3. Close PowerShell

If desired, instead of relying on the PowerShell aliases iex and iwr, you can run the
following instead:

`Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -Uri 'https://git.io/fjBQX').Content)`

Lastly, if it is preferred to do this step manually, you can. Some people feel it is a
security risk to run scripts from the web and as such want to avoid that practice. In
that case, just install Git and pull the repo to a local directory (preferably to the
\$profile\winfiles path, but this is not required). Afterward, you can start with Step 3
below from within the folder for this repository.

## Step 3: Run the 01-setup-profile Script

1. Open PowerShell as an Administrator
2. If not in the winfiles directory navigate to \$profile\winfiles
3. Run `.\01-setup-profile.ps1`
4. Close PowerShell

## Step 4: Run the 02-bootstrap Script

1. Open PowerShell as an Administrator
2. If not in the winfiles directory navigate to \$profile\winfiles
3. Run `.\02-bootstrap.ps1`
4. Reboot

This step will take a while. It sets up a bunch of registry settings as well as
installs\removes Windows modules and default applications. Be sure to reboot once
completed as that will "complete" many of the removals and installations.

## Step 5: (OPTIONAL): Manually install the Chocolatey license file

This is a good spot to pause and (manually) install the Chocolatey license file if you
have one. If you do, then the following application install steps will be faster and
more reliable as having a license allows the tool to use a non-open list of servers that
are more reliable.

During the installation of Chocolatey, the scripts pre-created the license folder
needed. Simply follow the steps below.

1. Get your license file (you should know where it is - **NOT SOMETHING TO BE PUT INTO
   GIT**) and copy it to the `C:\ProgramData\Chocolatey\license` directory
2. Open PowerShell as an Administrator
3. Run `choco install --force chocolatey.extension`
4. Afterward, run `choco` by itself and check the version string. It should read
   something like `Chocolatey vx.xx.xx Professional` or `Chocolatey vx.xx.xx Business`

## Step 6: Run the 03-app-installs Script

1. Open PowerShell as an Administrator
2. If not in the winfiles directory navigate to \$profile\winfiles
3. Run `.\03-app-installs.ps1`
4. Reboot (again)

This step will take a **LONG** time. During this step, be on the lookout for the
occasional dialog box during application installations. I have tried my best to ensure
that none of these installations will be blocking or have prompts, but it is a good idea
to be on the lookout and check the machine every now and again.

Again, the reboot may be necessary for some of the applications installed, so don't skip
that step.

## Step 7 (OPTIONAL): Run any or all of the optional install packages

This is an **optional** step and will include applications that are more single-purposed
in usage. At present, I have two "install packs". One for gaming and another for
development applications.

The game pack includes things like BattleNet, Steam, GOG Galaxy, and so on.

The development pack includes things like Visual Studio (which is quite large), docker,
and so on.

1. Open PowerShell as an Administrator
2. If not in the winfiles directory navigate to \$profile\winfiles
3. Run `.\optional-install-games.ps1` or `.\optional-install-development.ps1`
4. Reboot (yes, again - each time)

**NOTE**: These installations are more likely to have prompts or blocking dialogs so pay
attention during this script run more closely then the general installation above.

If you are performing this step at a later time it is safe to run the `04-cleanup.ps1`
script after it another time to clean things up.

## Step 8: Run the 04-cleanup Script

1. Open PowerShell as an Administrator
2. If not in the winfiles directory navigate to \$profile\winfiles.
3. Run `.\04-cleanup.ps1`
4. Close PowerShell.

This should conclude the "base" installation of the system. It includes the custom
settings ('winfiles' a.k.a. 'dotfiles'), a custom Windows configuration, as well as a
collection of applications I use on nearly every machine.

The manual steps finish any installations\configurations for any apps that require
prompts or other manual steps.

## Step 9: Manual Configurations

There are a few manual configurations that must be performed before continuing.

1. Point some Windows "special folders" to the profile location folders. The folders to
   redirect are:
   - Downloads
   - Music
   - Pictures
   - Videos
   - NOTE: DO NOT redirect 'My Documents', my profile 'documents' folder holds regular
     files and the 'My Documents' folders gets filled with a bunch of application
     garbage.
2. Log into Mega and configure Mega Sync (the most important folder to sync is the
   \$profile\cloud). I commonly also sync my music folder (\$profile\music) if the hard
   drives are large enough.
3. I like to configure "Quick Access" in a specific order. So, open File Explorer and
   add\remove paths to the "Quick Access" menu as follows:
   - profile (\$profile)
   - source (\$profile\source)
   - downloads (\$profile\downloads)
   - installs (\$profile\installs)
   - cloud (\$profile\cloud)
   - documents (\$profile\documents)
   - music (\$profile\music)
   - videos (\$profile\videos)
   - pictures (\$profile\pictures)
   - home (usually C:\users\<your username here>)

### License And Configure Applications

I use only a handful of licensed applications.

Directory Opus

The installation package installed Directory Opus but both the license and my
configuration need to be loaded.

I tend to store my license and configuration together in my "cloud" synced folder. But I
also have it on portable USB drives or other places. After locating the two files needed
install them into Directory Opus.

For those that want to obtain Directory Opus you can find the install and buy a license
here: https://www.gpsoft.com.au

It is one of the handful of licensed\proprietary applications that I use and it is **so
good** that I truly can't use Windows without it. It is a full replacement for the
Windows File Explorer.

### License Beyond Compare

Likewise with Directory Opus. Beyond Compare is another of the rare license applications
that I use. This one I even use on my Mac and Linux machines as well whereas Directory
Opus is Windows only.

### (Optional) License Visual Studio

TBD

## Step 10: Manual Installations

### Install Store Applications

Start by loading the "Microsoft Store" app and run all updates.

Use the "Microsoft Store" app to install the following (which can usually be seen in the
'Ready To Install' section):

- Dolby Access
- Microsoft Remote Desktop
- Netflix
- Hulu
- Twitter
- NPR One
- Alexa

For games:

- Microsoft Minesweeper
- Microsoft Sudoku
- Microsoft Solitaire Collection
- Microsoft Ultimate Word Games

### Install Applications With Prompts Or Dialogs

The following applications are available from Chocolatey or Scoop but bring up blocking
dialogs or require other immediate configuration to complete. So they must be manually
installed here. These all should be done within an Administrator PowerShell.

1. `choco install -y -r rainmeter`

### Install Applications Not Available In Chocolatey Or Scoop

Q: Why are most of these things in the "cloud" synced folder rather than the winfiles
folder?

A: Because I may not have legal right to re-distribute those files or they are sensitive
(like my settings).

#### Fonts

There are some fonts which need to be manually installed in the following locations:

1. `$profile\cloud\installs\windows\fonts\google`
2. `$profile\cloud\installs\windows\fonts\other`

Just right-click on all of the files and select "Install".

## Step 11: WSL Environment Configuration

TBD
