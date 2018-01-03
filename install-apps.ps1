#!/usr/bin/env powershell.exe
#Requires -Version 5
#Requires -RunAsAdministrator

Import-Module -DisableNameChecking "$PSScriptRoot\scripts\Utilities\AppInstaller.psm1"

Write-Host "Install Apps With Chocolatey" -foreground "green"

choco install -y "$PSScriptRoot/chocolatey-packages.config"

Write-Host "Install Apps - Automatic" -foreground "green"

### TODO: Install Chrome
###     (new-object System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', 'c:/temp/chrome.exe');. c:/temp/chrome.exe /silent /install;rm c:/temp -rec
### TODO: Install Slack
### TODO: Install mySMS
### TODO: Install DirectoryOpus
### TODO: Install Evernote
### TODO: Install Firefox
### TODO: Install AmazonMusic
### TODO: Install Atom
### TODO: Install Visual Studio Code
### TODO: Install dotnet core runtime


### On Dev Machines Only
### TODO: Install Docker
### TODO: Install Visual Studio
### TODO: Install Jetbrains Toolbox
### TODO: Install GhostDocPro
### TODO: Install OzCode
### TODO: Install SqlServer ? should switch to using docker for this
### TODO: Install SqlServer Management Studio
### TODO: Install TypeScript
### TODO: Install dotnet core sdk


###
# Other stuff to install...
# AutoHotkey
# Mezer Tools
# VPN Software (currently Cisco AnyConnect)
# Yarn (do NOT use Chocolatey for this)
