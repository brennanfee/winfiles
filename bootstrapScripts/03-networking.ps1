#!/usr/bin/env powershell.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Check PSRemoting"
try {
    Test-WSMan
}
catch {
    Write-Host "Setting network profiles to private"
    # Turn all network connections to "Private"
    Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private

    Write-Host "Enabling PSRemoting"
    Enable-PSRemoting -force
}
