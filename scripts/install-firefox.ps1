#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
param (
    [switch] $Force = $false
)

Set-StrictMode -Version 2.0

$wingetCmd = (Get-Command -Name winget.exe -ErrorAction SilentlyContinue)
if ($wingetCmd) {
    $wingetExe = "$($wingetCmd.Source)"
}
else {
    $wingetExe = Join-Path -Path "$env:LOCALAPPDATA" -ChildPath "Microsoft\WindowsApps\winget.exe"
}
if (-not (Test-Path -Path "$wingetExe")) {
    throw "Unable to locate WinGet, it must be installed first before this script will function."
}

### Check for and install Firefox if necessary
Write-Host "Checking for Firefox..." -ForegroundColor "Green"

if (-not (Test-Path "C:\Program Files\Mozilla Firefox\firefox.exe") -or $Force) {
    Write-Host "Firefox missing, preparing for install using WinGet."

    Write-Host ""
    & "$wingetExe" install --silent --accept-package-agreements --accept-source-agreements Mozilla.Firefox

    Write-Host "Firefox installed." -ForegroundColor "Cyan"
}
else {
    Write-Host "Firefox already installed." -ForegroundColor "Cyan"
}
Write-Host ""
