#!/usr/bin/env powershell.exe
#Requires -Version 5
#Requires -RunAsAdministrator
#Requires -PSEdition Desktop
Set-StrictMode -Version 2.0

# BAF - While this script is "usually" run after the 00-pull.ps1 script, it is intended that given circumstance the Winfiles repo could be pulled manually first and the pull script skipped.  As a result, this script performs some of the same steps as the 00-pull.ps1 to ensure success.

# Note, this may need to be run BEFORE this script
Set-ExecutionPolicy Bypass -Scope Process -Force -ErrorAction Ignore

& "$PSScriptRoot\scripts\set-system-type.ps1"

$scriptName = $MyInvocation.MyCommand.Name
Write-Host "Brennan Fee's WinFiles Setup Scripts - $scriptName" -ForegroundColor "Green"
Write-Host ""
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-Host "Setup Profile script started - $date" -ForegroundColor "Magenta"
Write-Host "System type: $env:SYSTEMTYPE"
Write-Host ""

& "$PSScriptRoot\scripts\configure-executionPolicies.ps1"

### Install Nuget provider if needed
$providers = Get-PackageProvider | Select-Object Name
if (-not ($providers.Contains("nuget"))) {
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force | Out-Null
}

### Install PowerShell modules
$moduleBlock = {
    Write-Host "Setting up PowerShell repositories"
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

    Write-Host "Upgrading built-in modules"
    Install-Module -Name PackageManagement -Scope AllUsers -Force
    Install-Module -Name PowerShellGet -Scope AllUsers -Force
    Install-Module -Name Pester -Scope AllUsers -Force -SkipPublisherCheck

    Write-Host "Updating modules"
    Update-Module -ErrorAction SilentlyContinue

    # Only the minimum necessary modules to make the profile work
    Write-Host "Installing modules"
    Install-Module -Name Pscx -AllowClobber -Scope CurrentUser -Force
}

Invoke-Command -ScriptBlock $moduleBlock

# Prepend the WinFiles modules folder to the module search path
$winfilesRoot = $PSScriptRoot
if (-not ("$env:PSModulePath".Contains("$winfilesRoot\powershell-modules"))) {
    $env:PSModulePath = "$winfilesRoot\powershell-modules;" + "$env:PSModulePath"
}

Write-Host "Importing modules"
Import-Module SystemUtilities
Import-Module MyCustomProfileUtilities

### Setup the PowerShell profile
Write-Host "Setting profile location"
Set-MyCustomProfileLocation

$logFile = "$env:PROFILEPATH\logs\winfiles\setup-profile.log"

Write-Log $logFile "----------"
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-LogAndConsole $logFile "Profile script log started - $date"
Write-LogAndConsole $logFile  "System type: $env:SYSTEMTYPE"
Write-LogAndConsole $logFile ""

Write-LogAndConsole $logFile "Installing posh-git"
$installPoshGit = "Install-Module -Name posh-git -AllowClobber -Scope CurrentUser " +
"-AllowPrerelease -Force"

Invoke-ExternalPowerShell -Command $installPoshGit

Write-LogAndConsole $logFile "Symlinking profile into place"

# First the traditional powershell profile
New-SymbolicLink $PROFILE "$winfilesRoot\powershell-profile\profile.ps1" -Force

# Also symlink for the Nuget profile
# TODO: Originally this was used by Visual Studio, not sure if VS 2017\2019
# still uses this or standard powershell.  Validate that this is still needed.
$profileLocation = Split-Path -Path $PROFILE -Parent
$nugetFile = Join-Path $profileLocation "NuGet_profile.ps1"

New-SymbolicLink $nugetFile "$winfilesRoot\powershell-profile\profile.ps1" -Force

### Check for and install Winget if necessary
& "$PSScriptRoot\scripts\install-winget.ps1"

### Check for and install PowerShell Core if necessary
& "$PSScriptRoot\scripts\install-powerShellCore.ps1"

Write-LogAndConsole $logFile "Installing modules for PowerShell Core"
Invoke-ExternalPowerShellCore $moduleBlock

Write-LogAndConsole $logFile "Installing posh-git for PowerShell Core"
Invoke-ExternalPowerShellCore $installPoshGit

# Profile for PowerShell Core
Write-LogAndConsole $logFile "Symlinking profile for PowerShell Core"
$myDocsFolder = [Environment]::GetFolderPath("MyDocuments")
$psCoreProfile = "$myDocsFolder\PowerShell\Microsoft.PowerShell_profile.ps1"
New-SymbolicLink $psCoreProfile "$winfilesRoot\powershell-profile\profile.ps1" -Force

Write-Host ""
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-LogAndConsole $logFile "Script Complete - $date" -Color "Magenta"
Write-Host ""
Write-LogAndConsole $logFile "Powershell profile setup complete" -Color "Green"
Write-Host ""
Write-LogAndConsole $logFile -Color "Yellow" `
    "You will need to close and re-open PowerShell to continue."
Write-LogAndConsole $logFile -Color "Yellow" `
    "Once reloaded as admin you can run .\02-bootstrap.ps1"
Write-Host ""
