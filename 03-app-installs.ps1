#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Invoke-Expression -command "$PSScriptRoot\shared\set-system-type.ps1"

$logPath = "$env:PROFILEPATH\logs\winfiles"
$logFile = "$logPath\appInstalls.log"
Write-Log $logFile "----------"
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-LogAndConsole $logFile "App Installs script started - $date"
Write-LogAndConsole $logFile "System type: $env:SYSTEMTYPE"
Write-LogAndConsole $logFile ""

Get-ChildItem "$PSScriptRoot\appInstallScripts" -File -Filter "*.ps1" | Sort-Object "FullName" | ForEach-Object {
    $script = $_.FullName
    $scriptName = [System.IO.Path]::GetFileNameWithoutExtension("$script")

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

    Write-LogAndConsole $logFile "Script finished: $script"
    Write-Host ""

    ## For debugging
    #[void](Read-Host -Prompt 'Press Enter to continue...')
}

Write-Host ""
Write-LogAndConsole $logFile "A reboot will be necessary (again)." -Color "Yellow"
Write-LogAndConsole $logFile "After reboot you can run .\04-cleanup.ps1" -Color "Yellow"
Write-Host ""
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-LogAndConsole $logFile "Script Complete - $date" -Color "Green"
