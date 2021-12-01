#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Installing applications using Winget - Development" -ForegroundColor "Green"

& "$PSScriptRoot\shared\set-system-type.ps1"

$logPath = "$env:PROFILEPATH\logs\winfiles"
$logFile = "$logPath\developmentInstalls.log"
Write-Log $logFile "----------"
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-LogAndConsole $logFile "Development Installs script started - $date"
Write-LogAndConsole $logFile "System type: $env:SYSTEMTYPE"
Write-LogAndConsole $logFile ""

## TODO: Add a thing to my profile to get the winget.exe with full path
$wingetExe = "winget.exe"

& "$wingetExe" import -i "$PSScriptRoot\optionalInstallPacks\development-apps.json" --ignore-unavailable --accept-source-agreements --accept-package-agreements

## Manually install visual studio
# "visualstudio2019professional" "--allWorkloads --includeRecommended --includeOptional --passive --locale en-US"

Write-Host ""
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-LogAndConsole $logFile "Script Complete - $date" -Color "Magenta"
Write-Host ""
Write-LogAndConsole $logFile "A reboot will be necessary (again)." -Color "Yellow"
Write-LogAndConsole $logFile "After reboot you can run .\04-cleanup.ps1" -Color "Yellow"
Write-Host ""
