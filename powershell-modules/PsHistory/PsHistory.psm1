#!/usr/bin/env powershell.exe
#Requires -Version 5

# TODO: Add documentation to each function

# Credit for the idea goes to this article:
# http://www.nivot.org/post/2009/08/15/PowerShell20PersistingCommandHistory.aspx

$psHistoryPath = Join-Path (split-path $profile) history.clixml
$psHistoryLength = 1000

function Init-PsHistory {
    [CmdletBinding()]
    param(
        [switch]$Silent = $false
    )
    # First, registor with the exit event to capture the history
    Register-EngineEvent -SourceIdentifier powershell.exiting -SupportEvent -Action {
        Get-History -Count $psHistoryLength | Export-Clixml -Path $psHistoryPath
    }

    # Second, load the previous history if it exists
    if ((Test-Path $psHistoryPath)) {
        $count = 0
        Import-Clixml -Path $psHistoryPath | Where-Object { $count++; $true } | Add-History
        if (! $Silent) {
            Write-Host -ForegroundColor Green "`nLoaded $count history item(s).`n"
        }
    }
}
