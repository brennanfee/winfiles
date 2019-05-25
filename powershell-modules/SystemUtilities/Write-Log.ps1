#!/usr/bin/env pwsh.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Get-LogFile {
    Param(
        [string]$Name,
        [string]$SubPath = ""
    )

    $logPath="$env:ProfilePath\logs"
    if ([string]::IsNullOrEmpty($SubPath)) {
        $logPath = Join-Path "$logPath" "$SubPath"
    }

    $fileName = "$Name.log"
    return Join-Path "$logPath" "$fileName"
}

function Write-Log {
    Param(
        [string]$LogFile,
        [string]$LogEntry
    )

    $path = Split-Path $LogFile -Parent
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path "$path" -Force -ErrorAction SilentlyContinue | Out-Null
    }

    $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
    Add-Content $logFile -value "$date : $LogEntry"
}

function Write-LogAndConsole {
    Param(
        [string]$LogFile,
        [string]$LogEntry,
        [string]$Color = ""
    )

    Write-Log -LogFile "$LogFile" -LogEntry "$LogEntry"

    if ([string]::IsNullOrEmpty($Color)) {
        Write-Host $LogEntry
    }
    else {
        Write-Host -ForegroundColor "$Color" $LogEntry
    }
}
