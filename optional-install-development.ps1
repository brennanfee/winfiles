#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Invoke-Expression -command "$PSScriptRoot\shared\set-system-type.ps1"

$logPath = "$env:PROFILEPATH\logs\winfiles"
$logFile = "$logPath\gameInstalls.log"
Write-Log $logFile "----------"
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-LogAndConsole $logFile "Game Installs script started - $date"
Write-LogAndConsole $logFile "System type: $env:SYSTEMTYPE"
Write-LogAndConsole $logFile ""

Write-Host "Installing applications using Chocolatey - Development"
Install-WithChocolateyList "$PSScriptRoot\optionalInstallScripts\development-apps.txt"

## Manually install visual studio
Install-WithChocolatey "visualstudio2019professional" "--allWorkloads --includeRecommended --includeOptional --passive --locale en-US"

Write-Host ""
Write-LogAndConsole $logFile "A reboot will be necessary (again)." -Color "Yellow"
Write-LogAndConsole $logFile "After reboot you can run .\04-cleanup.ps1" -Color "Yellow"
Write-Host ""
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-LogAndConsole $logFile "Script Complete - $date" -Color "Green"
