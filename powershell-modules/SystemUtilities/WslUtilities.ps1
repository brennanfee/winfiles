#!/usr/bin/env pwsh.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

$global:hasWslDistribution = $null

function Get-WslExe {
    return Get-Command "wsl.exe" -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Definition
}

function Invoke-WslCommand {
    [CmdletBinding()]
    param (
        [string]$WslCommand,
        [string]$Arguments,
        [string]$PowerShellFallback = ""
    )

    $wsl = Get-WslExe
    if ([string]::IsNullOrEmpty($wsl)) {
        # wsl.exe is not installed
        $global:hasWslDistribution = $false
    }
    if ($global:hasWslDistribution -eq $null) {
        # Need to perform a one time check to see if we have a WSL distribution installed...
        Invoke-Expression "wsl.exe -l --all"
        $global:hasWslDistribution = $LastExitCode -eq 0
    }

    if ($global:hasWslDistribution) {
        Invoke-Expression "wsl.exe $WslCommand $Arguments"
    }
    else {
        # We don't have WSL so use the PowerShellFallback

        # First, if the PowerShellFallback is blank, try a sane default
        if ([string]::IsNullOrEmpty($PowerShellFallback)) {
            if ($PowerShellFallback.StartsWith("ls ")) {
                $PowerShellFallback = "Get-ChildItem"
            }
            else {
                $PowerShellFallback = "$WslCommand"
            }
        }

        Invoke-Expression "$PowerShellFallback $Arguments"
    }
}

function Get-ListingUsingWsl {
    [CmdletBinding()]
    param (
        [string]$LsArguments,
        [string]$OtherArguments
    )

    Invoke-WslCommand "ls $LsArguments" "$OtherArguments" "Get-ChildItem"
}
