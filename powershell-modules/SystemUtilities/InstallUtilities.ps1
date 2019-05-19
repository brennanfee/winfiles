#!/usr/bin/env powershell.exe
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

