#!/usr/bin/env powershell.exe
#Requires -Version 5
#Requires -RunAsAdministrator
#Requires -PSEdition Desktop
param (
    [ValidateSet('main', 'develop', 'local')]
    [string] $Branch = "main"
)

Set-StrictMode -Version 2.0

# BAF - This script simply pulls the latest clean-install.ps1 script and executes it.  An optional branch name can be passed in to use a specific version.  "Local" can also be passed in but is used for debugging with a local copy of the files already in place.
#
# It is intended that this script be run directly from the web from the command line without any prior setup for the machine.  Use one of these commands:
#    Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -Uri 'https://git.io/fjBQX').Content)
# or shorter:
#    iex ((iwr -UseBasicParsing -Uri 'https://git.io/fjBQX').Content)

# Note, this may need to be run BEFORE this script
Set-ExecutionPolicy Bypass -Scope Process -Force -ErrorAction Ignore

# Set TLS 1.2 as the default in PowerShell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$currentScript = $MyInvocation.MyCommand.Name
Write-Host "Brennan Fee's WinFiles Pull Script - $currentScript" -ForegroundColor "Green"
Write-Host ""

$scriptName = "clean-install.ps1"
$tempPath = [System.IO.Path]::GetTempPath()

$scriptFile = Join-Path -Path $tempPath -ChildPath $scriptName

if ($Branch -eq "local") {
    Write-Host "Copying local $scriptName script file."
    $localPath = "$PSScriptRoot\scripts\$scriptName"

    Copy-Item -Path $localPath -Destination $scriptFile
}
else {
    Write-Host "Downloading current $scriptName script file for branch '$Branch'."
    $scriptUrl = "https://raw.githubusercontent.com/brennanfee/winfiles/$Branch/scripts/$scriptName"

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri $scriptUrl -OutFile $scriptFile
}

### Now execute that script
Write-Host "Running $scriptName script."
Write-Host ""
& "$scriptFile" -Branch $Branch
