#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

# At present there are four "packages" of applications.  "Main" applications are installed on every machine.  "Home" applications are installed on all non-work machines.  "Work" applications are only installed on work machines.  Finally, "Virtualization" applications are installed if the machine being installed to is not itself a virtual machine.

Write-Host "Installing applications using Chocolatey - Main"
$package = "$PSScriptRoot\choco-main-apps.config"
Invoke-Expression "choco install -y -r --skip-virus-check `"$package`""

if (-not ($env:SYSTEMTYPE -eq "WORK")) {
    Write-Host "Installing applications using Chocolatey - Non-Work"
    $package = "$PSScriptRoot\choco-nonWork-apps.config"
    Invoke-Expression "choco install -y -r --skip-virus-check `"$package`""
}

if ($env:SYSTEMTYPE -eq "WORK") {
    Write-Host "Installing applications using Chocolatey - Work Specific"
    $package = "$PSScriptRoot\choco-work-apps.config"
    Invoke-Expression "choco install -y -r --skip-virus-check `"$package`""
}

$computerDetails = Get-ComputerDetails

if (-not ($computerDetails.IsVirtual)) {
    Write-Host "Installing applications using Chocolatey - Virtualization"
    $package = "$PSScriptRoot\choco-virtualization-apps.config"
    Invoke-Expression "choco install -y -r --skip-virus-check `"$package`""
}

## Other applications to consider, installed only as needed
#
# audacity -> sound editing app
# blender -> 3d graphics editor
# blockbench -> 3d model editor
# clementine -> music organizer\player
# cryptomator -> encryption tool to be used with file sync tools
# gimp -> photo editing
# gnucash -> financial app
# harmony -> electron based music player, cross-plat
# inkscape -> vector graphics editor
# jitsi -> open source video conferencing
# kdenlive -> movie\video editor
# krita -> natural paint program
# libreoffice -> office suite
# mattermost -> open source version of slack
# meld -> open source replacement for beyond compare
# mp3tag -> what it sounds like
# mumble -> open source voice chat
# musescore -> music notation
# nextcloud -> the clinet app, if I ever get a server running
# obs-studio -> screen cam\screen recording
# openvpn -> open source vpn software
# patchwork -> open source secure chat app
# picard -> cross-plat music tagging tool
# pidgin -> chat app
# qtox -> another secure messaging app
# shotcut -> image\photo editor
# skype
# slack
# strawberry-music-player
# tagspaces
# telegram
# thomas -> open source cross-plat pomodoro timer
# twitch -> desktop client for the service
# udeler -> udemy course downloader
#
