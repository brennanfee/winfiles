#!/usr/bin/env pwsh.exe
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

### Powershell Modules
# Other package "providers"

#GitHubProvider -> git repo as a package\module
#GitLabProvider -> same as above but for GitLab
#ChocolateyGet -> how does this differ than the chocolatey one
#DockerProvider
#GistProvider
#AppxGet ?


#From PS Gallery

#powershell-yaml
#PSLogging

# JumpCloud
# Posh-SSH
# AWSPowerShell
# AWSPowerShell.NetCore
# JiraPS
# ACMESharp
# MSI
# BurntToast
# PsIni
# SSHSessions
# Logging
# PowerShellForGitHub
# Get-ChildItemColor -> fallback for wsl ls?
# windows-screenfetch
# Posh-ACME
# BetterCredentials
# SemVer
###

# Install Uplay (ubisoft)
#$url = "http://ubi.li/4vxt9"
#$output = "C:\Users\$env:username\Desktop\Programs\UPlay.exe"
#Invoke-WebRequest $url -OutFile $output
#Start-Process -FilePath "C:\Users\$env:username\Desktop\Programs\UPlay.exe" -ArgumentList "/S /silent /s" 2>&1 | Out-Null

# Install FireFox Nightly
#$url = "https://download.mozilla.org/?product=firefox-nightly-latest-ssl&os=win64&lang=en-US"
#$output = "C:\Users\$env:username\Desktop\Programs\FireFoxNightly.exe"
#Invoke-WebRequest $url -OutFile $output
#Start-Process -FilePath "C:\Users\$env:username\Desktop\Programs\FireFoxNightly.exe" -ArgumentList "/S /silent /s -ms" 2>&1 | Out-Null

# Install PushBullet
#$url = "https://update.pushbullet.com/pushbullet_installer.exe"
#$output = "C:\Users\$env:username\Desktop\Programs\PushBullet.exe"
#Invoke-WebRequest $url -OutFile $output
#Start-Process -FilePath "C:\Users\$env:username\Desktop\Programs\PushBullet.exe" -ArgumentList "/S /silent /s" 2>&1 | Out-Null




