#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

Set-Alias e Edit-File
Set-Alias edit Edit-File

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

function Get-ListingWslVdir { wsl.exe ls -lhAv --color=auto --group-directories-first --time-style=long-iso  $args }
Set-Alias vdir Get-ListingWslVdir

function Get-ListingWslTree { wsl.exe tree -C }
Set-Alias tree Get-ListingWslTree
