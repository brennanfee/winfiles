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
    $wslCommand = "ls -ohAv --color=never --group-directories-first " +
    "--time-style=long-iso $args | grep --color=never ^d"
    $psCommand = 'Get-ChildItem | Where-Object { $_.Mode.StartsWith(''d'') }'
    Invoke-WslCommand $wslCommand "" $psCommand
}
Set-Alias ldir Get-ListingWslLdir

function Get-ListingWslVdir { Get-ListingUsingWsl "-lhAv $commonArgs" "$args" }
Set-Alias vdir Get-ListingWslVdir

function Get-ListingWslTree { Invoke-WslCommand "tree -C" "" "tree.com" }
Set-Alias tree Get-ListingWslTree

function Search-ListingWslGrep {
    $wslCommand = "ls -A | grep -i $args"
    $psCommand = 'Get-ChildItem | Where-Object { $_.Name.Contains(''' + "$args" + ''') }'
    Invoke-WslCommand $wslCommand "" $psCommand
}
Set-Alias lsgrep Search-ListingWslGrep

function Search-ListingWslGrepLong {
    $wslCommand = "ls -hlA --time-style=long-iso | grep -i $args"
    $psCommand = 'Get-ChildItem | Where-Object { $_.Name.Contains(''' + "$args" + ''') }'
    Invoke-WslCommand $wslCommand "" $psCommand
}
Set-Alias llgrep Search-ListingWslGrepLong

function Search-ListingWslRg {
    $wslCommand = "ls -A | rg -S $args"
    $psCommand = 'Get-ChildItem | Where-Object { $_.Name.Contains(''' + "$args" + ''') }'
    Invoke-WslCommand $wslCommand "" $psCommand
}
Set-Alias lsrg Search-ListingWslRg

function Search-ListingWslRgLong {
    $wslCommand = "ls -hlA --time-style=long-iso | rg -S $args"
    $psCommand = 'Get-ChildItem | Where-Object { $_.Name.Contains(''' + "$args" + ''') }'
    Invoke-WslCommand $wslCommand "" $psCommand
}
Set-Alias llrg Search-ListingWslRgLong

Set-Alias mkdatedir New-DateDir
Set-Alias mkdatefile New-DateFile
