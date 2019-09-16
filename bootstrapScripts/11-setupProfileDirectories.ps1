#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

$directories = @(
    "cloud"
    "desktop"
    "documents"
    "downloads\installs"
    "music"
    "pictures"
    "source"
    "templates"
    "videos"
    "vms"
    "wsl"
)

foreach ($dir in $directories) {
    Write-Host ""
    Write-Host "Checking folder: $dir"

    $folder = "$env:PROFILEPATH\$dir"

    if (-not (Test-Path "$folder")) {
        New-Item -ItemType Directory -Force -Path $folder | Out-Null
        Write-Host "Folder created: $dir"
    }
}

