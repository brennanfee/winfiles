#!/usr/bin/env powershell.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Check PSRemoting"
$enabled = if (Test-WSMan -Authentication default 2> $null) { $true } else { $false }

if (-not $enabled) {
    Write-Host "Setting network profiles to private"
    # Turn all network connections to "Private"
    Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private

    Write-Host "Enabling PSRemoting"
    Enable-PSRemoting -Force -SkipNetworkProfileCheck
}
else {
    Write-Host "PSRemoting already enabled"
}
