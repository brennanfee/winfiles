#!/usr/bin/env powershell.exe
#Requires -Version 5
#Requires -RunAsAdministrator
#Requires -PSEdition Desktop
param (
    [switch] $Force = $false
)

Set-StrictMode -Version 2.0

$wingetCmd = (Get-Command -Name winget.exe)
if ($wingetCmd) {
    $wingetExe = "$($wingetCmd.Source)"
}
else {
    $wingetExe = Join-Path -Path "$env:LOCALAPPDATA" -ChildItem "Microsoft\WindowsApps\winget.exe"
}
if (-not (Test-Path -Path "$wingetExe")) {
    throw "Unable to locate WinGet, it must be installed first before this script will function."
}

### Check for and install Powershell Core if necessary
Write-Host "Checking for PowerShell Core..." -ForegroundColor "Green"
$powerShellPath = "C:\Program Files\PowerShell\7\pwsh.exe"
if (-not (Test-Path -Path $powerShellPath) -or $Force) {
    Write-Host "PowerShell Core missing, preparing for install using WinGet."

    Write-Host ""
    & "$wingetExe" install PowerShell --override "/quiet /passive ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1"

    if (Test-Path -Path ".\configure-executionPolicies.ps1") {
        & ".\configure-executionPolicies.ps1"
    }

    Write-Host "PowerShell Core installed." -ForegroundColor "Cyan"
}
else {
    Write-Host "PowerShell Core already installed." -ForegroundColor "Cyan"
}
Write-Host ""
