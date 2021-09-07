#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Symlinking the WinGet settings file." -ForegroundColor "Green"

$winfiles = Join-Path -Path "$env:PROFILEPATH" -ChildItem "winfiles"

$statePath = "$env:LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState"
$wingetSettingsFile = Join-Path -Path "$statePath" -ChildItem "settings.json"

if (-not (Test-Path $statePath)) {
    $null = New-Item -ItemType Directory -Force -Path $statePath
}

Remove-Item -Path "$wingetSettingsFile" -ErrorAction SilentlyContinue

New-SymbolicLink "$wingetSettingsFile" "$winFiles\settings\winget-settings.json"

Write-Host "WinGet settings file in place."
Write-Host ""
