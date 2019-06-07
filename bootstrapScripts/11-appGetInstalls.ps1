#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

$computerDetails = Get-ComputerDetails

Write-Host "Installing applications using AppGet - Main"
$apps = @(
    "7zip"
    "amazon-music"
    "amazon-workspaces"
    "autohotkey"
    "avidemux"
    #    "aws-tools-for-dotnet" # Needs to be manual, after install of Visual Studio
    "beyond-compare"
    "bitwarden"
    "bleachbit"
    "chrome"
    "cmake"
    "devdocs"
    "docker-community"
    "dotnet-core-sdk"
    "dotnet"
    #    "dropbox"
    "etcher"
    "firefox"
    "hack-fonts"
    "handbrake"
    "jetbrains-toolbox"
    "kindle"
    "megasync"
    #"miktex" -> scoop
    #"pandoc" -> scoop
    "pencil"
    "pia"
    "plex-media-player"
    "postman"
    #"pushbullet" # use Wavebox intead
    "rainmeter"
    "scribus"
    "signal"
    #"skype"
    #"spotify" # use the Windows Store version instead?
    "sqlectron"
    #"texmaker" -> scoop
    "visual-studio-code"
    "vlc"
    "wavebox"
    "zerotier-one"
)

foreach ($app in $apps) {
    Install-WithAppGet $app
}

if (-not ($global:InstallType -eq "work")) {
    Write-Host "Installing applications using AppGet - Non-Work"
    $apps = @(
        #        qbittorrent
        #        transmission
        #        transmission-remote-gui
        myharmony
    )

    foreach ($app in $apps) {
        Install-WithAppGet $app
    }
}

if ($global:InstallType -eq "gaming") {
    Write-Host "Installing applications using AppGet - Gaming"
    $apps = @(
        "battlenet"
        "geforce-experience" # nvidia only
        "gog-galaxy"
        "origin"
        "steam"
        "uplay"
    )

    foreach ($app in $apps) {
        Install-WithAppGet $app
    }
}

if (-not ($computerDetails.IsVirtual)) {
    Write-Host "Installing applications using AppGet - Virtualization"
    $apps = @(
        "vagrant"
        "virtualbox"
    )

    foreach ($app in $apps) {
        Install-WithAppGet $app
    }
}

######## Remove Desktop Icons
$desktop = Get-SpecialFolder "Desktop"
Remove-Item "$desktop\*.lnk" -ErrorAction SilentlyContinue
Remove-Item "$env:PUBLIC\Desktop\*.lnk" -ErrorAction SilentlyContinue

## Other AppGet packages available, installed only as needed
##
# blender -> 3d graphics editor
# blockbench -> 3d model editor
# clementine -> music organizer\player
# gimp -> photo editing
# harmony -> electron based music player, cross-plat
# inkscape -> vector graphics editor
# kdenlive -> movie\video editor
# krita -> natural paint program
# libreoffice -> office suite
# mp3tag -> what it sounds like
# musescore -> music notation
# nextcloud -> the clinet app, if I ever get a server running
# obs-studio -> screen cam\screen recording
# picard -> cross-plat music tagging tool
# shotcut -> image\photo editor
# slack
# twitch -> desktop client for the service
