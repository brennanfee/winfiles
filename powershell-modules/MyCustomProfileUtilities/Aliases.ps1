#!/usr/bin/env pwsh.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

Set-Alias e Edit-File
Set-Alias ge Edit-File # "graphical edit"
Set-Alias edit Edit-File
Set-Alias vis Edit-File # for "visual edit"

$commonArgs = "--color=auto --group-directories-first --time-style=long-iso"

function Get-ListingWslLs { Get-ListingUsingWsl "-v $commonArgs" "$args" }

function Get-ListingWslLss { Get-ListingUsingWsl "-1v $commonArgs" "$args" }
Set-Alias lss Get-ListingWslLss

function Get-ListingWslLa { Get-ListingUsingWsl "-Av $commonArgs" "$args" }
Set-Alias la Get-ListingWslLa

function Get-ListingWslLl { Get-ListingUsingWsl "-ohv $commonArgs" "$args" }
Set-Alias ll Get-ListingWslLl

function Get-ListingWslLla { Get-ListingUsingWsl "-ohAv $commonArgs" "$args" }
Set-Alias lla Get-ListingWslLla

function Get-ListingWslLls { Get-ListingUsingWsl "-lhAv $commonArgs" "$args" }
Set-Alias lls Get-ListingWslLls

function Get-ListingWslLdir {
    $wsl = Get-WslExe

    if ([string]::IsNullOrEmpty($wsl)) {
        Get-ChildItem | Where-Object { $_.Mode.StartsWith('d') }
    }
    else {
        wsl.exe ls -ohAv --color=never --time-style=long-iso "$args" |
        wsl.exe grep --color=never '^d'
    }
}
Set-Alias ldir Get-ListingWslLdir

function Get-ListingWslVdir { Get-ListingUsingWsl "-lhAv $commonArgs" "$args" }
Set-Alias vdir Get-ListingWslVdir

function Get-ListingWslTree { Invoke-WslCommand "tree -C" "" "tree.com" }
Set-Alias tree Get-ListingWslTree

function Search-ListingWslGrep {
    $wsl = Get-WslExe

    if ([string]::IsNullOrEmpty($wsl)) {
        Get-ChildItem | Where-Object { $_.Name.Contains("$args") }
    }
    else {
        wsl.exe ls -A | wsl.exe grep -i "$args"
    }
}
Set-Alias lsgrep Search-ListingWslGrep

function Search-ListingWslGrepLong {
    $wsl = Get-WslExe

    if ([string]::IsNullOrEmpty($wsl)) {
        Get-ChildItem | Where-Object { $_.Name.Contains("$args") }
    }
    else {
        wsl.exe ls -hlA --time-style=long-iso | wsl.exe grep -i "$args"
    }
}
Set-Alias llgrep Search-ListingWslGrepLong

function Search-ListingWslRg {
    $wsl = Get-WslExe

    if ([string]::IsNullOrEmpty($wsl)) {
        Get-ChildItem | Where-Object { $_.Name.Contains("$args") }
    }
    else {
        wsl.exe ls -A | wsl.exe rg -S "$args"
    }
}
Set-Alias lsrg Search-ListingWslRg

function Search-ListingWslRgLong {
    $wsl = Get-WslExe

    if ([string]::IsNullOrEmpty($wsl)) {
        Get-ChildItem | Where-Object { $_.Name.Contains("$args") }
    }
    else {
        wsl.exe ls -hlA --time-style=long-iso | wsl.exe rg -S "$args"
    }
}
Set-Alias llrg Search-ListingWslRgLong

Set-Alias mkdatedir New-DateDir
Set-Alias mkdatefile New-DateFile
