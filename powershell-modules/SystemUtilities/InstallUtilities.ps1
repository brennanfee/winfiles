#!/usr/bin/env pwsh.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Add-ScoopBucket {
    Param(
        [string]$Bucket
    )

    $buckets = scoop bucket list

    if (-not ($buckets.Contains($Bucket))) {
        Write-Host "Adding scoop bucket: $Bucket"
        Invoke-Expression "scoop bucket add $Bucket"
    }
}

function Install-WithScoop {
    Param(
        [string]$App,
        [string]$VerifyPath,
        [switch]$Global = $false
    )

    if (-not (Test-Path $VerifyPath)) {
        Write-Host "Install with scoop: $App"
        $command = "scoop install $App"
        if ($Global) {
            $command += " -g"
        }
        Invoke-Expression $command
    }
    else {
        Write-Host "App already installed: $App"
    }
}

function Install-WithAppGet {
    Param(
        [string]$App,
        [string]$VerifyPath
    )

    if (-not (Test-Path $VerifyPath)) {
        Write-Host "Install with AppGet: $App"
        $command = "$env:ALLUSERSPROFILE\AppGet\bin\appget.exe install -s -v `"$App`""
        Invoke-Expression $command

    }
    else {
        Write-Host "App already installed: $App"
    }
}
