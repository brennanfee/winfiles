#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

$directories = @(
    "cloud"
    "documents"
    "downloads"
    "installs"
    "mounts"
    "music"
    "pictures"
    "source\github"
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

if ($env:SYSTEMTYPE -eq "WORK") {
    Write-Host "Setting up extra work related directories"

    $directories = @(
        "source\personal"
        "workdocs" ## Only for Amazon
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
}
