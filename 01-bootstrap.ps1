#!/usr/bin/env powershell.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

# Note, these may need to be run BEFORE this script
Set-ExecutionPolicy Unrestricted -scope LocalMachine -Force -ErrorAction Ignore
Set-ExecutionPolicy Unrestricted -scope CurrentUser -Force -ErrorAction Ignore

$logPath = "$env:ProfilePath\logs\winfiles"
$logFile = "$logPath\bootstrap.log"
Write-Log $logFile "----------"
Write-LogAndConsole $logFile "Bootstrap script started"

Get-ChildItem "$PSScriptRoot\bootstrapScripts" -File -Filter "*.ps1" | Sort-Object "FullName" | ForEach-Object {
    $script = $_.FullName
    $scriptName = [io.path]::GetFileNameWithoutExtension("$script")

    Write-Host ""
    Write-LogAndConsole $logFile "Running script: $script"

    try {
        Start-Transcript -Path "$logPath\script-$scriptName.log" -Append
        Invoke-Expression -command "$script"
        Start-Sleep -Seconds 1
    }
    finally {
        Stop-Transcript
    }
}
