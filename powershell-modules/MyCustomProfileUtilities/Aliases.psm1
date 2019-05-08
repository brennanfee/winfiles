#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

Set-Alias e Edit-File

# TODO: Can I use the wsl command line here to get real ls?
Set-Alias la Get-ChildItem
Set-Alias ll Get-ChildItem
Set-Alias lla Get-ChildItem

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
