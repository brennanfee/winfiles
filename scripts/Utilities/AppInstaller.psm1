#!/usr/bin/env powershell.exe
#Requires -Version 5

function RunMsiFromUrl($url, $appName)
{
    $tempFileName = [System.IO.Path]::GetTempFileName();

    Write-Host "Downloading $appName"
    Invoke-WebRequest $url -UseBasicParsing -o $tempFileName

    RunMsiInstall $tempFileName $appName
}

function RunMsiInstall($msi, $appName)
{
    Write-Host "Install $appName"
    $outputPath = "$PSScriptRoot\..\..\output"
    $logFile = "$outputPath\install-$appName.log"

    $MsiArguments = @(
        "/i"
        ('"{0}"' -f $msi)
        "/qn"
        "/norestart"
        "/L*v"
        $logFile
    )
    Start-Process "msiexec.exe" -ArgumentList $MsiArguments -Wait -NoNewWindow
}
