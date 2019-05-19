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
    Write-LogAndConsole $logFile "Running script: $_.FullName"

    try {
        #-UseMinimalHeader
        Start-Transcript -Path "$logPath\script-$_.log" -Append -IncludeInvocationHeader
        Invoke-Expression -command "$_.FullName"
    }
    finally {
        Start-Sleep -Seconds 1
        Stop-Transcript
    }
}
