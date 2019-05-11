#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

Set-Alias e Edit-File
Set-Alias edit Edit-File

function Get-ListingWslLs { wsl.exe ls --color=auto --group-directories-first }
#TODO: Neither of these are working
Set-Alias ls Get-ListingWslLs -Option AllScope
Set-Alias sl Get-ListingWslLs

function Get-ListingWslLa { wsl.exe ls -A --color=auto --group-directories-first }
Set-Alias la Get-ListingWslLa

function Get-ListingWslLl { wsl.exe ls -oh --color=auto --group-directories-first --time-style=long-iso }
Set-Alias ll Get-ListingWslLl

function Get-ListingWslLla { wsl.exe ls -ohA --color=auto --group-directories-first --time-style=long-iso }
Set-Alias lla Get-ListingWslLla

function Get-ListingWslLls { wsl.exe ls -lhA --color=auto --group-directories-first --time-style=long-iso }
Set-Alias lls Get-ListingWslLls

function Get-ListingWslLdir { wsl.exe ls -ohA --color=never --group-directories-first --time-style=long-iso | wsl.exe grep --color=never "^d" }
Set-Alias ldir Get-ListingWslLdir

function Get-ListingWslVdir { wsl.exe ls -lhA --color=auto --group-directories-first --time-style=long-iso }
Set-Alias vdir Get-ListingWslVdir

function Get-ListingWslTree { wsl.exe tree -C }
Set-Alias tree Get-ListingWslTree
