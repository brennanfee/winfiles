#!/usr/bin/env pwsh.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Get-LogFile {
    Param(
        [string]$LogName,
        [string]$SubPath = ""
    )

    $logPath = "$env:PROFILEPATH\logs"
    if ([string]::IsNullOrEmpty($SubPath)) {
        $logPath = Join-Path "$logPath" "$SubPath"
    }

    if ([string]::IsNullOrEmpty([io.path]::GetExtension($LogName))) {
        $LogName = "${LogName}.log"
    }

    return Join-Path "$logPath" "$LogName"
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
