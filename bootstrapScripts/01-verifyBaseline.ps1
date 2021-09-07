#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

# This script verifies the baseline and corrects what is needed.
# It is ALWAYS expected that users run 01-setup-profile.ps1 but not
# necessarily 00-pull.ps1.  This will cover the situation where they did
# skip 00-pull.ps1.  As a result, there is some code duplication between
# this script and 00-pull.ps1.  Changes to 00-pull.ps1 may need to be copied
# to here.

Write-Host "Verifying baseline" -ForegroundColor "Green"
Write-Host ""

# Setup the profile environment variable
Write-Host "Setting profile location"
Set-MyCustomProfileLocation -Force

### Check for and install Winget if necessary
& "$PSScriptRoot\..\scripts\install-winget.ps1"

### Check for and install PowerShell Core if necessary
& "$PSScriptRoot\..\scripts\install-powerShellCore.ps1"

### Check for and install OpenSSH if necessary
& "$PSScriptRoot\..\scripts\install-ssh.ps1"

### Check for and install Git if necessary
& "$PSScriptRoot\..\scripts\install-git.ps1"

### Pull the Winfiles, if needed
# I know it might look odd to check for pulling the Winfiles repo.  But,
# while the user is obviously running these files from within a copy of the Winfiles,
# there is no gaurantee they are in the "right" location or that they pulled it using Git.
& "$PSScriptRoot\..\scripts\pull-winfiles.ps1"

### Check for and install Firefox if necessary
& "$env:PROFILEPATH\winfiles\scripts\install-firefox.ps1"

### Finally, ensure the system type is set
& "$env:PROFILEPATH\winfiles\shared\set-system-type.ps1"

Write-Host "Baseline verified and adjusted as needed"
Write-Host ""
