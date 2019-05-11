#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

Set-Alias e Edit-File
Set-Alias edit Edit-File

function Get-ListingWslLs { wsl.exe ls --color=auto --group-directories-first }
Set-Alias ls Get-ListingWslLs -Options AllScope

function Get-ListingWslLa { wsl.exe ls -A --color=auto --group-directories-first }
Set-Alias la Get-ListingWslLa

function Get-ListingWslLl { wsl.exe ls -oh --color=auto --group-directories-first --time-style=long-iso }
Set-Alias ll Get-ListingWslLl

function Get-ListingWslLla { wsl.exe ls -ohA --color=auto --group-directories-first --time-style=long-iso }
Set-Alias lla Get-ListingWslLla

function Get-ListingWslLls { wsl.exe ls -ohA --color=auto --group-directories-first --time-style=long-iso }
Set-Alias lls Get-ListingWslLls

function Get-ListingWslLdir { wsl.exe ls -ohA --color=never --group-directories-first --time-style=long-iso | grep --color=never "^d" }
Set-Alias ldir Get-ListingWslLdir

function Get-ListingWslVdir { wsl.exe ls -A --color=auto --group-directories-first --format=long }
Set-Alias vdir Switch-LocationWslVdir

function Get-ListingWslTree { wsl.exe tree -C }
Set-Alias tree Get-ListingWslTree

# TODO: Change to match the linux cd aliases
function Switch-LocationParent { Set-Location ".." }
Set-Alias cd. Switch-LocationParent
Set-Alias cd.. Switch-LocationParent
Set-Alias cdu Switch-LocationParent

Set-Alias cdp Switch-ToProfileFolder

function Switch-LocationToDesktop { Switch-ToSpecialFolder "DesktopDirectory" }
Set-Alias cdk Switch-LocationToDesktop

function Switch-LocationToTemplates { Switch-ToProfileFolder "Templates" }
Set-Alias cdl Switch-LocationToTemplates

function Switch-LocationToSource { Switch-ToProfileFolder "source" }
Set-Alias cds Switch-LocationToSource

function Switch-LocationToSourcePersonal { Switch-ToProfileFolder "source\personal" }
Set-Alias cdss Switch-LocationToSourcePersonal

function Switch-LocationToSourceGithub { Switch-ToProfileFolder "source\github" }
Set-Alias cdsg Switch-LocationToSourceGithub

function Switch-LocationToDownloads { Switch-ToProfileFolder "downloads" }
Set-Alias cdd Switch-LocationToDownloads

function Switch-LocationToInstalls { Switch-ToProfileFolder "downloads\installs" }
Set-Alias cdi Switch-LocationToInstalls

function Switch-LocationToMusic { Switch-ToSpecialFolder "MyMusic" }
Set-Alias cdm Switch-LocationToMusic

function Switch-LocationToMusicPlaylist { Switch-ToSpecialFolder "MyMusic" "playlists" }
Set-Alias cdmp Switch-LocationToMusicPlaylist

function Switch-LocationToMounts { Switch-ToProfileFolder "mounts" }
Set-Alias cdmt Switch-LocationToMounts

function Switch-LocationToVideos { Switch-ToSpecialFolder "MyVideos" }
Set-Alias cdv Switch-LocationToVideos

function Switch-LocationToVms { Switch-ToProfileFolder "vms" }
Set-Alias cdvm Switch-LocationToVms

function Switch-LocationToDropbox { Switch-ToProfileFolder "dropbox" }
Set-Alias cddb Switch-LocationToDropbox

function Switch-LocationToMyDocuments { Switch-ToSpecialFolder "My Documents" }
Set-Alias cdmd Switch-LocationToMyDocuments

#NOTE: This is NOT the "My Documents" special folder
function Switch-LocationToDocuments { Switch-ToProfileFolder "documents" }
Set-Alias cdc Switch-LocationToDocuments

function Switch-LocationToPictures { Switch-ToSpecialFolder "MyPictures" }
Set-Alias cdx Switch-LocationToPictures

function Switch-LocationToHome { Switch-ToSpecialFolder "UserProfile" }
Set-Alias cdh Switch-LocationToHome

function Switch-LocationToWinfiles { Switch-ToProfileFolder "winfiles" }
Set-Alias cdw Switch-LocationToWinfiles

#TODO: cdr - to to root of git folder
