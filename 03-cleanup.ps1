#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

$logPath = "$env:PROFILEPATH\logs\winfiles"
$logFile = "$logPath\cleanup.log"
Write-Log $logFile "----------"
Write-LogAndConsole $logFile "Cleanup script started"

Get-ChildItem "$PSScriptRoot\cleanupScripts" -File -Filter "*.ps1" | Sort-Object "FullName" | ForEach-Object {
    $script = $_.FullName
    $scriptName = [System.IO.Path]::GetFileNameWithoutExtension("$script")

    Write-Host ""
    Write-LogAndConsole $logFile "Running script: $script"

    try {
        Start-Transcript -Path "$logPath\cleanup-$scriptName.log" -Append
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
Write-LogAndConsole $logFile -Color "Yellow" `
    "You will need to close and re-open PowerShell to continue."
Write-Host ""
Write-LogAndConsole $logFile "Complete" -Color "Green"
