#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

# This script verifies the baseline and corrects what is needed.
# It is ALWAYS expected that users run 01-setup-profile.ps1 but not
# necessary 00-pull.ps1.  This will cover the situation where they did
# skip 00-pull.ps1.  As a result, there is some code duplication between
# this script and 00-pull.ps1.  Changes to 00-pull.ps1 may need to be copied
# to here.

Write-Host "Verifying baseline"

# Setup the profile environment variable
Write-Host "Setting profile location"
Set-MyCustomProfileLocation -Force

# Check if scoop is already installed
if (-not (Test-Path "$env:ProfilePath\scoop\shims\scoop")) {
    Write-Host "Scoop missing, preparing for install"
    [environment]::SetEnvironmentVariable('SCOOP', "$env:ProfilePath\scoop", 'User')
    $env:SCOOP = "$env:ProfilePath\scoop"
    [environment]::SetEnvironmentVariable('SCOOP_GLOBAL', 'C:\scoop-global', 'Machine')
    $env:SCOOP_GLOBAL = 'C:\scoop-global'

    # Install scoop
    Write-Host ""
    Set-StrictMode -Off # Need to turn StrictMode off because Scoop script has errors
    Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -Uri 'https://get.scoop.sh').Content)
    Set-StrictMode -Version 2.0
    Write-Host ""

    # Scoop configuration
    Add-MpPreference -ExclusionPath $env:SCOOP
    Add-MpPreference -ExclusionPath $env:SCOOP_GLOBAL
    Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1

    Write-Host "Scoop installed." -ForegroundColor "Green"
}
else {
    Write-Host "Scoop already installed." -ForegroundColor "Green"
}

# Check if git is already installed
if (-not (Test-Path "$env:SCOOP_GLOBAL\shims\git.exe")) {
    Write-Host "Git missing, preparing for install using scoop."

    Write-Host ""
    Invoke-Expression "scoop install --global sudo 7zip git git-lfs innounp dark which aria2"
    Write-Host ""

    [environment]::SetEnvironmentVariable('GIT_SSH', (resolve-path (scoop which ssh)), 'USER')
    $env:GIT_SSH = (resolve-path (scoop which ssh))
    Write-Host "Git installed." -ForegroundColor "Green"
}
else {
    Write-Host "Git already installed." -ForegroundColor "Green"
}

# I know it might look odd to check for pulling the Winfiles repo.  But,
# while the user is obviously running these files from within a copy of the Winfiles,
# there is no gaurantee they are in the right location.

### Pull the WinFiles repo from GitHub
if (-not (Test-Path "$env:ProfilePath\winfiles\README.md")) {
    Write-Host "Winfiles missing, preparing to clone"

    Write-Host ""
    Invoke-Expression "git clone --recurse-submodules https://github.com/brennanfee/winfiles.git `"$env:ProfilePath\winfiles`""
    Write-Host ""

    Write-Host "Finished cloning winfiles." -ForegroundColor "Green"
}
else {
    Write-Host "Winfiles already set up." -ForegroundColor "Green"
}
