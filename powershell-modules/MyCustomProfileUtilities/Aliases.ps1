#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

Set-Alias e Edit-File
Set-Alias edit Edit-File

function Get-ListingWslLs { wsl.exe ls --color=auto --group-directories-first }
Set-Alias ls Get-ListingWslLs -Option AllScope

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

Set-Alias cdp Switch-LocationToProfileFolder

Set-Alias cdk Switch-LocationToDesktop

function Switch-LocationToTemplates { Switch-LocationToProfileFolder "Templates" }
Set-Alias cdl Switch-LocationToTemplates

function Switch-LocationToSource { Switch-LocationToProfileFolder "source" }
Set-Alias cds Switch-LocationToSource

function Switch-LocationToSourcePersonal { Switch-LocationToProfileFolder "source\personal" }
Set-Alias cdss Switch-LocationToSourcePersonal

function Switch-LocationToSourceGithub { Switch-LocationToProfileFolder "source\github" }
Set-Alias cdsg Switch-LocationToSourceGithub

function Switch-LocationToDownloads { Switch-LocationToProfileFolder "downloads" }
Set-Alias cdd Switch-LocationToDownloads

function Switch-LocationToInstalls { Switch-LocationToProfileFolder "downloads\installs" }
Set-Alias cdi Switch-LocationToInstalls

Set-Alias cdm Switch-LocationToMusic

function Switch-LocationToMusicPlaylist { Switch-LocationToSpecialFolder "MyMusic" "playlists" }
Set-Alias cdmp Switch-LocationToMusicPlaylist

function Switch-LocationToMounts { Switch-LocationToProfileFolder "mounts" }
Set-Alias cdmt Switch-LocationToMounts

Set-Alias cdv Switch-LocationToVideos

function Switch-LocationToVms { Switch-LocationToProfileFolder "vms" }
Set-Alias cdvm Switch-LocationToVms

function Switch-LocationToDropbox { Switch-LocationToProfileFolder "dropbox" }
Set-Alias cddb Switch-LocationToDropbox

Set-Alias cdmd Switch-LocationToMyDocuments

#NOTE: This is NOT the "My Documents" special folder
function Switch-LocationToDocuments { Switch-LocationToProfileFolder "documents" }
Set-Alias cdc Switch-LocationToDocuments

Set-Alias cdx Switch-LocationToPictures

Set-Alias cdh Switch-LocationToHome

function Switch-LocationToWinfiles { Switch-LocationToProfileFolder "winfiles" }
Set-Alias cdw Switch-LocationToWinfiles

#TODO: cdr - to to root of git folder
