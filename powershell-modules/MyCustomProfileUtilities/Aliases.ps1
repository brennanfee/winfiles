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
Set-Alias cd. cd ..
Set-Alias cd.. cd ..
Set-Alias cdu cd ..

Set-Alias cdp Switch-ToProfileFolder
Set-Alias cdk Switch-ToSpecialFolder "DesktopDirectory"
Set-Alias cdl Switch-ToSpecialFolder "Templates" # Might not be what I want.  TODO: Test
Set-Alias cds Switch-ToProfileFolder "source"
Set-Alias cdss Switch-ToProfileFolder "source\personal"
Set-Alias cdsg Switch-ToProfileFolder "source\github"
Set-Alias cdd Switch-ToProfileFolder "downloads"
Set-Alias cdi Switch-ToProfileFolder "downloads\installs"
Set-Alias cdm Switch-ToSpecialFolder "MyMusic"
Set-Alias cdmp Switch-ToSpecialFolder "MyMusic" "playlists"
Set-Alias cdmt Switch-ToProfileFolder "mounts"
Set-Alias cdv Switch-ToSpecialFolder "MyVideos"
Set-Alias cdvm Switch-ToProfileFolder "vms"
Set-Alias cddb Switch-ToProfileFolder "dropbox"
#NOTE: This is NOT the "My Documents" special folder
Set-Alias cdc Switch-ToProfileFolder "documents"
Set-Alias cdx Switch-ToSpecialFolder "MyPictures"
Set-Alias cdh Switch-ToSpecialFolder "UserProfile"
Set-Alias cdw Switch-ToProfileFolder "winfiles"

#TODO: cdr - to to root of git folder
