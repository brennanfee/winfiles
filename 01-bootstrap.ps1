#!/usr/bin/env powershell.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

# Note, these may need to be run BEFORE this script
Set-ExecutionPolicy RemoteSigned -scope LocalMachine -Force
Set-ExecutionPolicy Unrestricted -scope CurrentUser -Force

### Set Profile location (based on how many disks we have)
### 1 disk means porfile is in C:\profile, 2 disks or more means D:\profile
$DriveCount = (Get-PhysicalDisk | Measure-Object).Count

$profilesPath="C:\profile"
if ($DriveCount -ge 2) {
    $profilesPath="D:\profile"
}
$winfilesRoot="$profilesPath\winfiles"

### Setup logging
$logPath="$profilesPath\logs\winfiles"
$logFile="$logPath\bootstrap.log"
if (-not Test-Path -PathType Container -Path $logPath) {
    New-Item -ItemType Directory -Force -Path
}

function LogWrite {
    Param(
        [string]$logEntry
        [switch]$Success
    )

    # TODO: Add date\time?
    Add-Content $logFile -value $logEntry
    if ($Success) {
        Write-Host -ForegroundColor 'Green' $logEntry
    } else {
        Write-Host $logEntry
    }
}

LogWrite "Bootstrap script started."

### Phase 1 - If the winfiles are not there, pull them from GitHub
if (!(Test-Path "$winfilesRoot\README.md")) {
    LogWrite "Winfiles missing, preparing to download"
    # Check if scoop is already installed
    if (-not (Test-Path "$profilesPath\scoop\shims\scoop")) {
        LogWrite "Scoop missing, preparing for install"
        [environment]::setEnvironmentVariable('SCOOP', "$profilesPath\scoop", 'User')
        $env:SCOOP="$profilesPath\scoop"
        [environment]::setEnvironmentVariable('SCOOP_GLOBAL','C:\scoop-global','Machine')
        $env:SCOOP_GLOBAL='C:\scoop-global'

        # Install scoop
        iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

        LogWrite "Scoop installed." -Success
    }

    # Check if git is already installed
    if (-not (Test-Path "$env:USERPROFILE\scoop\shims\git.exe")) {
        LogWrite "Git missing, preparing for install."
        # Install git
        scoop install sudo 7zip git which --global
        [environment]::setenvironmentvariable('GIT_SSH', (resolve-path (scoop which ssh)), 'USER')
        LogWrite "Git installed." -Success
    }

    # Pull the repo
    LogWrite "Cloning Winfiles repo"
    git clone --recurse-submodules "https://github.com/brennanfee/winfiles.git" "$winfilesRoot"

    LogWrite "Finished downloading winfiles." -Success
} else {
    LogWrite "Winfiles already set up." -Success
}

## Now run the "admin" setup script
