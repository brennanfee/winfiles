#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
param (
    [switch] $Force = $false
)

Set-StrictMode -Version 2.0

$needToInstall = $false
$neededVersionMinimum = "1.16.12986.0"
$hasPackageManager = Get-AppPackage -name "Microsoft.DesktopAppInstaller"

Write-Host "Checking for WinGet..." -ForegroundColor "Green"

if ($Force) {
    Write-Host "Force was passed, will install latest from GitHub."
    $needToInstall = $true
}
elseif (!$hasPackageManager) {
    Write-Host "AppInstaller package missing, will install latest from GitHub."
    $needToInstall = $true
}
elseif ([version]$hasPackageManager.Version -lt [version]$neededVersionMinimum) {
    Write-Host "Current version of AppInstaller package is old, will install latest from GitHub."
    $needToInstall = $true
}

if ($needToInstall) {
    $releases_url = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $releases = Invoke-RestMethod -uri "$($releases_url)"
    $latestRelease = $releases.assets | Where-Object { $_.browser_download_url.EndsWith("msixbundle") } | Select-Object -First 1

    $tempPath = [System.IO.Path]::GetTempPath()
    $downloadFile = Join-Path -Path $tempPath -ChildPath "Microsoft.DesktopAppInstaller.msixbundle"
    Invoke-WebRequest -Uri $latestRelease.browser_download_url -OutFile $downloadFile

    Add-AppxPackage -Path $downloadFile

    Remove-Item -Path $downloadFile

    Write-Host "WinGet now installed." -ForegroundColor "Cyan"
}
else {
    Write-Host "WinGet already installed." -ForegroundColor "Cyan"
}

Write-Host ""
