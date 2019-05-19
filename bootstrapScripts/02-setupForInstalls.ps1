#!/usr/bin/env powershell.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

# Copy paste.exe to C:\Windows\system32 directory
if (-not (Test-Path "$env:SystemRoot\system32\paste.exe")) {
    Write-Host "Copying paste.exe"
    Copy-Item -Path "$env:ProfilePath\winfiles\installs\paste.exe" -Destination "$env:SystemRoot\system32"
}

# Setup "extras" repo for scoop
Write-Host "Setting up scoop buckets"
Add-ScoopBucket "main"
Add-ScoopBucket "extras"
Add-ScoopBucket "nerd-fonts"
Add-ScoopBucket "java"

# Install AppGet
#Invoke-Expression "$env:ProfilePath\winfiles\installs\appget.exe"
