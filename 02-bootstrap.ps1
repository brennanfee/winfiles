#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator

Param(
    [Parameter(ValueFromPipeline = $true,
        ValueFromPipelineByPropertyName = $true)]
    [ValidateSet('home','work','gaming')]
    [string] $InstallType = "home"
)

Set-StrictMode -Version 2.0
$global:InstallType = $InstallType

$logPath = "$env:ProfilePath\logs\winfiles"
$logFile = "$logPath\bootstrap.log"
Write-Log $logFile "----------"
Write-LogAndConsole $logFile "Bootstrap script started"
Write-LogAndConsole $logFile "Install type: $global:InstallType"

Get-ChildItem "$PSScriptRoot\bootstrapScripts" -File -Filter "*.ps1" | Sort-Object "FullName" | ForEach-Object {
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

rundll32.exe user32.dll, UpdatePerUserSystemParameters

# Kill and restart explorer
taskkill.exe /F /IM "explorer.exe"
explorer.exe

Write-Host ""
Write-LogAndConsole $logFile "A reboot will be necessary for settings to take effect." -Color "Yellow"
Write-LogAndConsole $logFile "After reboot you can run .\03-cleanup.ps1" -Color "Yellow"
Write-Host ""
Write-LogAndConsole $logFile "Complete" -Color "Green"
