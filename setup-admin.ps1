#!/usr/bin/env powershell.exe
#Requires -Version 5
#Requires -RunAsAdministrator

# This script runs the setup scripts that require admin privileges.  A reboot
# WILL be required for the settings to take effect.

$scriptsPath = "$PSScriptRoot\scripts"
$outputPath = "$PSScriptRoot\output"

if (!(Test-Path $outputPath))
{
    New-Item $outputPath -ItemType Directory -Force
}

@(
    "SettingsAdmin"
) | ForEach-Object {
    $directory = $_
    Write-Host "Running $directory scripts" -foreground "green"

    Get-ChildItem "$scriptsPath\$directory" -File -Filter "*.ps1" | Sort-Object "FullName" | ForEach-Object {
        $script = $_.FullName
        Write-Host "Running script: $script"
        & "$script" *> "$outputPath\log-$directory-$_.log"
        Start-Sleep 1
    }
}

Write-Host "A reboot is necessary for settings to take effect." -foreground "yellow"
Write-Host "Complete" -foreground "green"
