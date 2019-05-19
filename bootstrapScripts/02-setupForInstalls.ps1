#!/usr/bin/env powershell.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

# Copy paste.exe to C:\Windows\system32 directory
Write-Host "Checking for paste.exe"
if (-not (Test-Path "$env:SystemRoot\system32\paste.exe")) {
    Write-Host "Copying paste.exe"
    Copy-Item -Path "$env:ProfilePath\winfiles\installs\paste.exe" -Destination "$env:SystemRoot\system32"
}
else {
    Write-Host "Paste.exe already in place"
}

# Setup "extras" repo for scoop
Write-Host "Setting up scoop buckets"
Add-ScoopBucket "main"
Add-ScoopBucket "extras"
Add-ScoopBucket "nerd-fonts"
Add-ScoopBucket "java"
Write-Host "Scoop buckets configured"

# Install AppGet
Write-Host "Checking for AppGet"
if (-not (Test-Path "C:\ProgramData\AppGet\bin\appget.exe")) {
    Write-Host "Installing AppGet"
    $logFile="$env:ProfilePath\logs\winfiles\appget-install.log"
    $command = "$env:ProfilePath\winfiles\installs\appget.exe /VERYSILENT /SUPPRESSMSGBOXES /SP `"/LOG=$logFile`""
    Invoke-Expression -command $command
}
else {
    Write-Host "AppGet already installed"
}
