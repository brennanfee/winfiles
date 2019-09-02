# Installation Steps

This document covers the entire process (both automatic and manual) that I follow when setting up a new Windows machine.

## 1: Install Windows & Run Updates

This is a manual step.  During installation, Windows should be connected to your Microsoft account.
Reboot as needed.

Don't forget to update the Windows Store and its apps.

## 2: Run the 00-pull Script

1. Open PowerShell as an Administrator
2. Run `iex ((iwr -UseBasicParsing -Uri 'https://git.io/fjBQX').Content)`

If desired, instead of relying on the PowerShell aliases iex and iwr, you can run the following instead:

`Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -Uri 'https://git.io/fjBQX').Content)`

## 3: Run the 01-setup-profile Script

1. If not in the winfiles directory navigate to C:\profile\winfiles or D:\profile\winfiles (depending on if you have one hard drive or two).
2. Run `.\01-setup-profile.ps1`
3. Close PowerShell.

## 4: Run the 02-bootstrap Script

1. Open PowerShell as an Administrator
2. If not in the winfiles directory navigate to C:\profile\winfiles or D:\profile\winfiles (depending on if you have one hard drive or two).
3. Run `.\02-bootstrap.ps1`
    * As an option you can pass an install "type" like so `.\02-bootstrap.ps1 -InstallType "home"`.  "Home" is the default with "work" and "gaming" as other options.  The primary difference between the install types are what applications and settings are being used.

During this step, be on the lookout for the occasional dialog box during application installations.

