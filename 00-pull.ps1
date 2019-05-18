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

function Write-Log {
    Param(
        [string]$LogEntry
        [switch]$Color = ""
    )

    $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
    Add-Content $logFile -value "$date : $LogEntry"
    if ([string]::IsNullOrEmpty($Color)) {
        Write-Host $LogEntry
    }
    else {
        Write-Host -ForegroundColor "$Color" $LogEntry
    }
}

Write-Log "Bootstrap script started."

### Phase 1 - If the winfiles are not there, pull them from GitHub
if (-not (Test-Path "$winfilesRoot\README.md")) {
    Write-Log "Winfiles missing, preparing to download"
    # Check if scoop is already installed
    if (-not (Test-Path "$profilesPath\scoop\shims\scoop")) {
        Write-Log "Scoop missing, preparing for install"
        [environment]::setEnvironmentVariable('SCOOP', "$profilesPath\scoop", 'User')
        $env:SCOOP="$profilesPath\scoop"
        [environment]::setEnvironmentVariable('SCOOP_GLOBAL','C:\scoop-global','Machine')
        $env:SCOOP_GLOBAL='C:\scoop-global'

        # Install scoop
        iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

        Write-Log "Scoop installed." -Color "Green"
    }

    # Check if git is already installed
    if (-not (Test-Path "$env:SCOOP_GLOBAL\shims\git.exe")) {
        Write-Log "Git missing, preparing for install."
        # Install git
        scoop install sudo 7zip git which --global
        [environment]::setenvironmentvariable('GIT_SSH', (resolve-path (scoop which ssh)), 'USER')
        Write-Log "Git installed." -Color "Green"
    }

    # Pull the repo
    Write-Log "Cloning Winfiles repo"
    git clone --recurse-submodules "https://github.com/brennanfee/winfiles.git" "$winfilesRoot"

    Write-Log "Finished downloading winfiles." -Color "Green"
} else {
    Write-Log "Winfiles already set up." -Color "Green"
}

Invoke-Expression -command "$winfilesRoot\setup-profile.ps1"
Write-Log "You will need to close and re-open PowerShell to continue." -Color "Yellow"
Write-Log "Complete" -Color "Green"
