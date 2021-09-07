#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

& "$PSScriptRoot\shared\set-system-type.ps1"

$scriptName = $MyInvocation.MyCommand.Name
Write-Host "Brennan Fee's WinFiles Setup Scripts - $scriptName" -ForegroundColor "Green"
Write-Host ""
$logPath = "$env:PROFILEPATH\logs\winfiles"
$logFile = "$logPath\bootstrap.log"
Write-Log $logFile "----------"
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-LogAndConsole $logFile "Bootstrap script started - $date" -ForegroundColor "Magenta"
Write-LogAndConsole $logFile "System type: $env:SYSTEMTYPE"
Write-LogAndConsole $logFile ""
Write-Host ""

# One more time just to ensure that both PowerShell and PowerShell Core are properly configured
& "$PSScriptRoot\scripts\configure-executionPolicies.ps1"

Get-ChildItem "$PSScriptRoot\bootstrapScripts" -File -Filter "*.ps1" | Sort-Object "FullName" | ForEach-Object {
    $script = $_.FullName
    $scriptName = [System.IO.Path]::GetFileNameWithoutExtension("$script")

    Write-Host ""
    Write-LogAndConsole $logFile "Running script: $script"

    try {
        Start-Transcript -Path "$logPath\script-$scriptName.log" -Append
        #        Invoke-Expression -command "$script"
        & "$script"
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

rundll32.exe user32.dll, UpdatePerUserSystemParameters

# Kill and restart explorer
taskkill.exe /F /IM "explorer.exe"
explorer.exe

Write-Host ""
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-LogAndConsole $logFile "Script Complete - $date" -Color "Magenta"
Write-Host ""
Write-LogAndConsole $logFile "A reboot will be necessary for settings to take effect." -Color "Yellow"
Write-LogAndConsole $logFile "After reboot you can run .\03-app-installs.ps1" -Color "Yellow"
Write-Host ""
