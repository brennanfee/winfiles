#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

## Resolve InstallType
$installType = "home"
if (Test-Path variable:global:InstallType) {
    $installType = $global:InstallType
}

Write-Host "Installing applications using AppGet - Main"
$apps = @(
    "7zip"
    "amazon-music"
    "amazon-workspaces"
    "autohotkey"
    "avidemux"
    "aws-cli"
    #    "aws-tools-for-dotnet" # Needs to be manual, after install of Visual Studio
    "beyond-compare"
    "bitwarden"
    "bleachbit"
    "chrome"
    "cmake"
    "devdocs"
    "dotnet-sdk"
    #    "dropbox"
    "etcher"
    "evernote"
    "firefox"
    "ghostscript"
    "hack-fonts"
    "handbrake"
    "hashcheck"
    "imagemagick"
    "jetbrains-toolbox"
    "kindle"
    "megasync"
    "miktex"
    "pandoc"
    "pencil"
    "plex-media-player"
    "postman"
    #"rainmeter" # Shows prompts during install
    "scribus"
    "signal"
    #"spotify"  # Won't install under an administrator shell
    "sqlectron"
    "teams"
    "texmaker"
    "visual-studio-code"
    "vlc"
    "wavebox"
    "zerotier-one"
)

foreach ($app in $apps) {
    Install-WithAppGet $app
}

if (-not ($installType -eq "work")) {
    Write-Host "Installing applications using AppGet - Non-Work"
    $apps = @(
        # Torrent apps
        "qbittorrent"
        "transmission"
        "transmission-remote-gui"
        # Harmony remote
        "myharmony"
        # PIA VPN
        #"pia" # Shows prompts during install, install manually instead
        # Game installers
        #"battlenet"  # Shows prompts during install, install manually instead
        "gog-galaxy"
        #"origin"  # Shows prompts during install, install manually instead
        "steam"
        "uplay"
    )

    foreach ($app in $apps) {
        Install-WithAppGet $app
    }
}

$computerDetails = Get-ComputerDetails

if (-not ($computerDetails.IsVirtual)) {
    Write-Host "Installing applications using AppGet - Virtualization"
    $apps = @(
        "vagrant"
        "virtualbox"
        #"docker-community"  # Shows prompts during install, install manually instead
    )

    foreach ($app in $apps) {
        Install-WithAppGet $app
    }
}

## Other AppGet packages available, installed only as needed
##
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
