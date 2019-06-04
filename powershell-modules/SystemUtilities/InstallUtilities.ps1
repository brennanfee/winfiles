#!/usr/bin/env pwsh.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Add-ScoopBucket {
    Param(
        [string]$Bucket
    )

    Write-Host ""
    Write-Host "Checking scoop bucket: $Bucket"

    $buckets = scoop bucket list

    if (-not ($buckets.Contains($Bucket))) {
        Write-Host "Adding scoop bucket: $Bucket"

        Invoke-Expression "scoop bucket add $Bucket"

        Write-Host "Scoop bucket added: $Bucket"
    }
    else {
        Write-Host "Scoop bucket already configured: $Bucket"
    }
}

function Install-WithScoop {
    Param(
        [string]$App,
        [string]$VerifyCommand,
        [switch]$Global
    )

    Write-Host ""
    Write-Host "Checking for Scoop app: $App"

    if ([string]::IsNullOrEmpty($env:VerifyCommand)) {
        $VerifyCommand = $App + ".exe"
    }

    if (-not (Get-Command -Name $VerifyCommand -ErrorAction SilentlyContinue)) {
        Write-Host "Install with Scoop: $App"

        $command = "scoop install $App"
        if ($Global) {
            $command += " -g"
        }
        Invoke-Expression $command

        Write-Host "App installed: $App"
    }
    else {
        Write-Host "App already installed: $App"
    }
}

function Install-WithAppGet {
    Param(
        [string]$App
    )

    Write-Host ""
    Write-Host "Checking for AppGet app: $App"

    $apps = AppGet.exe list

    if (-not ($apps.Contains($App))) {
        Write-Host "Installing with AppGet: $App"

        $command = "$env:ALLUSERSPROFILE\AppGet\bin\appget.exe install -s -v `"$App`""
        Invoke-Expression $command

        Write-Host "App installed: $App"
    }
    else {
        Write-Host "App already installed: $App"
    }
}
