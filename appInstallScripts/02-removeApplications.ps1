#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Removing pre-installed applications" -ForegroundColor "Green"
Write-Host ""

# There are a few applications Microsoft pre-installs that I want to remove

## TODO: Add a thing to my profile to get the winget.exe with full path
$wingetExe = "winget.exe"

# Can't uninstall Edge at present because even with silent it prompts.
#& "$wingetExe" uninstall --silent Microsoft.Edge

& "$wingetExe" install --silent Microsoft.OneDrive

Write-Host "Application removal complete"
Write-Host ""
