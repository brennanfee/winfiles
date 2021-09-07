#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Setting up profile directories" -ForegroundColor "Green"

# Standard directories
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

    $folder = Join-Path -Path "$env:PROFILEPATH" -ChildPath "$dir"

    if (-not (Test-Path "$folder")) {
        $null = New-Item -ItemType Directory -Force -Path $folder
        Write-Host "Folder created: $dir"
    }
}

# Work specific directories
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
            $null = New-Item -ItemType Directory -Force -Path $folder
            Write-Host "Folder created: $dir"
        }
    }
}

# Now re-map the Windows folders to the new locations
$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"

$directoryMappings = @(
    [pscustomobject]@{WindowsDir = '{374DE290-123F-4565-9164-39C4925E467B}'; ProfileDir = 'downloads' }
    [pscustomobject]@{WindowsDir = 'My Music'; ProfileDir = 'music' }
    [pscustomobject]@{WindowsDir = 'My Pictures'; ProfileDir = 'pictures' }
    [pscustomobject]@{WindowsDir = 'My Video'; ProfileDir = 'videos' }
)

foreach ($mapping in $directoryMappings) {
    $windowsDir = $mapping.WindowsDir
    $profileDir = Join-Path -Path $env:PROFILEPATH -ChildPath $mapping.ProfileDir
    Set-RegistryString $key $windowsDir $profileDir
}

Write-Host "Profile directories configured"
Write-Host ""
