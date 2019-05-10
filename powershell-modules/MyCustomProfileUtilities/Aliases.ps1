#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

Set-Alias e Edit-File
Set-Alias edit Edit-File

Function lsWslFunc {}
Set-Alias ls lsWslFunc

Function laWslFunc { wsl.exe ls -A --color=auto --group-directories-first }
Set-Alias la laWslFunc

Function llWslFunc { wsl.exe ls -oh --color=auto --group-directories-first --time-style=long-iso }
Set-Alias ll llWslFunc

Function llaWslFunc { wsl.exe ls -ohA --color=auto --group-directories-first --time-style=long-iso }
Set-Alias lla llaWslFunc

Function llsWslFunc { wsl.exe ls -ohA --color=auto --group-directories-first --time-style=long-iso }
Set-Alias lls llsWslFunc

Function ldirWslFunc { wsl.exe ls -ohA --color=never --group-directories-first --time-style=long-iso | grep --color=never "^d" }
Set-Alias ldir ldirWslFunc

Function vdirWslFunc { wsl.exe ls -A --color=auto --group-directories-first --format=long }
Set-Alias vdir vdirWslFunc

Function treeWslFunc { wsl.exe tree -C }
Set-Alias tree wsl tree -C

# TODO: Change to match the linux cd aliases
Function cdDotFunc { Set-Location ".." }
Set-Alias cd. cdDotFunc
Set-Alias cd.. cdDotFunc
Set-Alias cdu cdDotFunc

Set-Alias cdp Switch-ToProfileFolder

Function cdkFunc { Switch-ToSpecialFolder "DesktopDirectory" }
Set-Alias cdk cdkFunc

# Might not be what I want.  TODO: Test
Function cdlFunc { Switch-ToSpecialFolder "Templates" }
Set-Alias cdl cdlFunc

Function cdsFunc { Switch-ToProfileFolder "source" }
Set-Alias cds cdsFunc

Function cdssFunc { Switch-ToProfileFolder "source\personal" }
Set-Alias cdss cdssFunc

Function csgFunc { Switch-ToProfileFolder "source\github" }
Set-Alias cdsg csgFunc

Function cddFunc { Switch-ToProfileFolder "downloads" }
Set-Alias cdd cddFunc

Function cdiFunc { Switch-ToProfileFolder "downloads\installs" }
Set-Alias cdi cdiFunc

Function cdmFunc { Switch-ToSpecialFolder "MyMusic" }
Set-Alias cdm cdmFunc

Function cdmpFunc { Switch-ToSpecialFolder "MyMusic" "playlists" }
Set-Alias cdmp cdmpFunc

Function cdmtFunc { Switch-ToProfileFolder "mounts" }
Set-Alias cdmt cdmtFunc

Function cdvFunc { Switch-ToSpecialFolder "MyVideos" }
Set-Alias cdv cdvFunc

Function cdvmFunc { Switch-ToProfileFolder "vms" }
Set-Alias cdvm cdvmFunc

Function cddbFunc { Switch-ToProfileFolder "dropbox" }
Set-Alias cddb cddbFunc

#NOTE: This is NOT the "My Documents" special folder
Function cdcFunc { Switch-ToProfileFolder "documents" }
Set-Alias cdc cdcFunc

Function cdxFunc { Switch-ToSpecialFolder "MyPictures" }
Set-Alias cdx cdxFunc

Function cdhFunc { Switch-ToSpecialFolder "UserProfile" }
Set-Alias cdh cdhFunc

Function cdwFunc { Switch-ToProfileFolder "winfiles" }
Set-Alias cdw cdwFunc

#TODO: cdr - to to root of git folder
