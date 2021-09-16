#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
param (
    [ValidateSet('main', 'develop')]
    [string] $Branch = "main"
)
Set-StrictMode -Version 2.0

$gitCmd = (Get-Command -Name git.exe)
if ($gitCmd) {
    $gitExe = "$($gitCmd.Source)"
}
else {
    $gitExe = Join-Path -Path "$env:PROGRAMFILES" -ChildPath "Git\cmd\git.exe"
}
if (-not (Test-Path -Path "$gitExe")) {
    throw "Unable to locate Git, it must be installed first before this script will function."
}

### Check for and pull the WinFiles repo if necessary
Write-Host "Checking for WinFiles..." -ForegroundColor "Green"
$winfilesPath = Join-Path -Path $env:PROFILEPATH -ChildPath "winfiles"
$readme = Join-Path -Path $winfilesPath -ChildPath "readme.md"
if (-not (Test-Path -Path $readme)) {
    Write-Host "Winfiles missing, preparing to clone"

    Write-Host ""
    & "$gitExe" clone --recurse-submodules https://github.com/brennanfee/winfiles.git "$winfilesPath"
    Write-Host ""

    # Switch branch if needed
    if ($Branch -ne "main") {
        $currentLocation = Get-Location
        Set-Location "$winfilesPath"
        & "$gitExe" switch $Branch
        Set-Location $currentLocation
    }

    Write-Host "Finished cloning winfiles." -ForegroundColor "Cyan"
}
else {
    Write-Host "Winfiles already cloned." -ForegroundColor "Cyan"
}

Write-Host ""
