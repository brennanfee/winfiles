#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Invoke-MsiInstaller {
    [CmdletBinding()]
    param(
        [string]$Msi,
        [string]$AppName = ""
    )

    if ([string]::IsNullOrEmpty($AppName)) {
        $AppName = [System.IO.Path]::GetFileNameWithoutExtension($Msi) +
            [System.IO.Path]::GetExtension($Msi)
    }

    Write-Host "Install $AppName"
    $outputPath = "$PSScriptRoot\..\..\output"
    $logFile = "$outputPath\install-$AppName.log"

    $MsiArguments = @(
        "/i"
        ('"{0}"' -f $Msi)
        "/qn"
        "/norestart"
        "/L*v"
        $logFile
    )
    Start-Process "msiexec.exe" -ArgumentList $MsiArguments -Wait -NoNewWindow
}

function Invoke-MsiInstallerFromUrl {
    [CmdletBinding()]
    param(
        [string]$Url,
        [string]$AppName = ""
    )

    if ([string]::IsNullOrEmpty($AppName)) {
        $AppName = [System.IO.Path]::GetFileNameWithoutExtension($Url) +
            [System.IO.Path]::GetExtension($Url)
    }

    $tempFileName = [System.IO.Path]::GetTempFileName();

    Write-Host "Downloading $AppName"
    Invoke-WebRequest $Url -UseBasicParsing -o $tempFileName

    Invoke-MsiInstaller $tempFileName $AppName
}
