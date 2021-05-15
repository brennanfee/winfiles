#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

# At present there are four "packages" of applications.  "Main" applications are installed on every machine.  "Home" applications are installed on all non-work machines.  "Work" applications are only installed on work machines.  Finally, "Virtualization" applications are installed if the machine being installed to is not itself a virtual machine.

Write-Host "Installing applications using Chocolatey - Main"
Install-WithChocolateyList "$PSScriptRoot\main-apps.txt"

if (-not ($env:SYSTEMTYPE -eq "WORK")) {
    Write-Host "Installing applications using Chocolatey - Non-Work"
    Install-WithChocolateyList "$PSScriptRoot\nonWork-apps.txt"
}

if ($env:SYSTEMTYPE -eq "WORK") {
    Write-Host "Installing applications using Chocolatey - Work Specific"
    Install-WithChocolateyList "$PSScriptRoot\work-apps.txt"
}

$computerDetails = Get-ComputerDetails

if (-not ($computerDetails.IsVirtual)) {
    Write-Host "Installing applications using Chocolatey - Virtualization"
    Install-WithChocolateyList "$PSScriptRoot\virtualization-apps.txt"
}
