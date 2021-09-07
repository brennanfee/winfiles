#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Installing Application Packs" -ForegroundColor "Green"
Write-Host ""

# At present there are four "packages" of applications.  "Main" applications are installed on every machine.  "Home" applications are installed on all non-work machines.  "Work" applications are only installed on work machines.  Finally, "Virtualization" applications are installed if the machine being installed to is not itself a virtual machine.

## TODO: Add a thing to my profile to get the winget.exe with full path
$wingetExe = "winget.exe"

Write-Host "Installing applications using WinGet - Main"
& "$wingetExe" import -i "$PSScriptRoot\main-apps.json" --silent --ignore-unavailable

if (-not ($env:SYSTEMTYPE -eq "WORK")) {
    Write-Host "Installing applications using WinGet - Non-Work"
    & "$wingetExe" import -i "$PSScriptRoot\nonWork-apps.json" --silent --ignore-unavailable
}

if ($env:SYSTEMTYPE -eq "WORK") {
    Write-Host "Installing applications using WinGet - Work Specific"
    & "$wingetExe" import -i "$PSScriptRoot\work-apps.json" --silent --ignore-unavailable
}

$computerDetails = Get-ComputerDetails

if (-not ($computerDetails.IsVirtual)) {
    Write-Host "Installing applications using WinGet - Virtualization"
    & "$wingetExe" import -i "$PSScriptRoot\virtualization-apps.json" --silent --ignore-unavailable
}

Write-Host "Application packs installed"
Write-Host ""
