#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Preparing for installations" -ForegroundColor "Green"
Write-Host ""

# Symlink in the Winget Settings
& "$PSScriptRoot\..\scripts\symlink-winget-settings.ps1"

# This would be the place to run the WinGet command to install secondary sources and the like.  At present I am not using any alternate or additional sources so there is nothing else to do.

Write-Host "Install preperations complete"
Write-Host ""
