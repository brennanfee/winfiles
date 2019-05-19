#!/usr/bin/env powershell.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

# Note, these may need to be run BEFORE this script
Set-ExecutionPolicy Unrestricted -scope LocalMachine -Force -ErrorAction Ignore
Set-ExecutionPolicy Unrestricted -scope CurrentUser -Force -ErrorAction Ignore

$logPath="$env:ProfilePath\logs\winfiles"
$logFile = "$logPath\bootstrap.log"
Write-LogAndConsole $logFile "Bootstrap script started"

Get-ChildItem "$PSScriptRoot\bootstrapScripts" -File -Filter "*.ps1" | Sort-Object "FullName" | ForEach-Object {
    $script = $_.FullName
    Write-LogAndConsole $logFile "Running script: $script"
    Invoke-Expression -command "$script *> `"$logPath\script-$_.log`""
    Start-Sleep 1
}
