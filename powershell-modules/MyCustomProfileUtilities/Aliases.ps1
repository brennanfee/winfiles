#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

Set-Alias e Edit-File
Set-Alias edit Edit-File

Set-Alias ls wsl ls --color=auto --group-directories-first
Set-Alias la wsl ls -A --color=auto --group-directories-first
Set-Alias ll wsl ls -oh --color=auto --group-directories-first --time-style=long-iso
Set-Alias lla wsl ls -ohA --color=auto --group-directories-first --time-style=long-iso
Set-Alias lls wsl ls -ohA --color=auto --group-directories-first --time-style=long-iso
Set-Alias ldir wsl ls -ohA --color=never --group-directories-first --time-style=long-iso | grep --color=never "^d"
Set-Alias vdir wsl ls -A --color=auto --group-directories-first --format=long
Set-Alias tree wsl tree -C

# TODO: Change to match the linux cd aliases
Set-Alias sdown Switch-ToDownloadsLocation
Set-Alias sdownload Switch-ToDownloadsLocation
Set-Alias sdownloads Switch-ToDownloadsLocation

Set-Alias sproj Switch-ToProjectsLocation
Set-Alias sproject Switch-ToProjectsLocation
Set-Alias sprojects Switch-ToProjectsLocation

Set-Alias ssource Switch-ToWorkSourceLocation
Set-Alias swork Switch-ToWorkSourceLocation

Set-Alias swinfiles Switch-ToWinFilesLocation

Set-Alias sprofile Switch-ToProfileLocation

Set-Alias smusic Switch-ToMusicLocation

Set-Alias svideo Switch-ToVideosLocation
Set-Alias svideos Switch-ToVideosLocation

Set-Alias spicture Switch-ToPicturesLocation
Set-Alias spictures Switch-ToPicturesLocation
Set-Alias spics Switch-ToPicturesLocation

Set-Alias sdocs Switch-ToDocumentsLocation
Set-Alias sdocuments Switch-ToDocumentsLocation
