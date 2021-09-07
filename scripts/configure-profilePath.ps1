#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Configurationg Profile Path" -ForegroundColor "Green"

### Set Profile location (based on how many disks we have)
# 1 disk means porfile is in C:\profile, 2 disks or more means D:\profile
$driveCount = (Get-PhysicalDisk | Measure-Object).Count

$profilesPath = "C:\profile"
if ($driveCount -ge 2) {
    $profilesPath = "D:\profile"
}
[Environment]::SetEnvironmentVariable("PROFILEPATH", $profilesPath, "User")
$env:PROFILEPATH = $profilesPath
if (-not (Test-Path "$env:PROFILEPATH")) {
    $null = New-Item -ItemType Directory -Force -Path $env:PROFILEPATH
}

Write-Host "Profile path configured."
Write-Host ""
