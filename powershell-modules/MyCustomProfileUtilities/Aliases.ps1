#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

Set-Alias e Edit-File
Set-Alias ge Edit-File # "graphical edit"
Set-Alias edit Edit-File
Set-Alias vis Edit-File # for "visual edit"

function Get-ListingWslLs { wsl.exe ls -v --color=auto --group-directories-first $args }

function Get-ListingWslLss { wsl.exe ls -1v --color=auto --group-directories-first $args }
Set-Alias lss Get-ListingWslLss

function Get-ListingWslLa { wsl.exe ls -Av --color=auto --group-directories-first $args }
Set-Alias la Get-ListingWslLa

function Get-ListingWslLl { wsl.exe ls -ohv --color=auto --group-directories-first --time-style=long-iso $args }
Set-Alias ll Get-ListingWslLl

function Get-ListingWslLla { wsl.exe ls -ohAv --color=auto --group-directories-first --time-style=long-iso $args }
Set-Alias lla Get-ListingWslLla

function Get-ListingWslLls { wsl.exe ls -lhAv --color=auto --group-directories-first --time-style=long-iso $args }
Set-Alias lls Get-ListingWslLls

function Get-ListingWslLdir { wsl.exe ls -ohAv --color=never --group-directories-first --time-style=long-iso $args | wsl.exe grep --color=never "^d" }
Set-Alias ldir Get-ListingWslLdir

function Get-ListingWslVdir { wsl.exe ls -lhAv --color=auto --group-directories-first --time-style=long-iso $args }
Set-Alias vdir Get-ListingWslVdir

function Get-ListingWslTree { wsl.exe tree -C }
Set-Alias tree Get-ListingWslTree

function Search-ListingWslGrep { wsl.exe ls -A | grep -i "$args" }
Set-Alias lsgrep

function Search-ListingWslGrepLong { wsl.exe ls -hlA --time-style=long-iso | grep -i "$args" }
Set-Alias llgrep

function Search-ListingWslRg { wsl.exe ls -A | rg -S "$args" }
Set-Alias lsrg

function Search-ListingWslRgLong { wsl.exe ls -hlA --time-style=long-iso | rg -S "$args" }
Set-Alias llrg

Set-Alias mkdatedir New-DateDir
Set-Alias mkdatefile New-DateFile
