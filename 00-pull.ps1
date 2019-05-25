#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

# BAF - The purpose of this script is to do the minimum necessary to pull
# my WinFiles repository onto the current machine.  The "WinFiles" are like
# Linux "dotfiles" but for Windows.  It is intended that this script be run
# directly from the web from the command line without any prior setup for
# the machine.  Use this command:
#    Invoke-Expression ((Invoke-WebRequest -Uri 'https://git.io/fjBQX').Content)

# Note, these may need to be run BEFORE this script
Set-ExecutionPolicy Unrestricted -scope LocalMachine -Force -ErrorAction Ignore
Set-ExecutionPolicy Unrestricted -scope CurrentUser -Force -ErrorAction Ignore

### Set Profile location (based on how many disks we have)
### 1 disk means porfile is in C:\profile, 2 disks or more means D:\profile
$DriveCount = (Get-PhysicalDisk | Measure-Object).Count

$profilesPath = "C:\profile"
if ($DriveCount -ge 2) {
    $profilesPath = "D:\profile"
}
[Environment]::SetEnvironmentVariable("ProfilePath", $profilesPath, "User")
$env:ProfilePath = $profilesPath

$winfilesRoot = "$env:ProfilePath\winfiles"

### Setup logging
$logFile = "$env:ProfilePath\logs\winfiles\00-pull.log"

function Write-Log {
    Param(
        [string]$LogEntry,
        [string]$Color = ""
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

Write-Log "----------"
Write-Log "Pull script started."

# Check if scoop is already installed
if (-not (Test-Path "$env:ProfilePath\scoop\shims\scoop")) {
    Write-Log "Scoop missing, preparing for install"
    [environment]::SetEnvironmentVariable('SCOOP', "$env:ProfilePath\scoop", 'User')
    $env:SCOOP = "$env:ProfilePath\scoop"
    [environment]::SetEnvironmentVariable('SCOOP_GLOBAL', 'C:\scoop-global', 'Machine')
    $env:SCOOP_GLOBAL = 'C:\scoop-global'

    # Install scoop
    Invoke-Expression ((Invoke-WebRequest -Uri 'https://get.scoop.sh').Content)

    Write-Log "Scoop installed." -Color "Green"
}
else {
    Write-Log "Scoop already installed." -Color "Green"
}

# Check if git is already installed
if (-not (Test-Path "$env:SCOOP_GLOBAL\shims\git.exe")) {
    Write-Log "Git missing, preparing for install using scoop."

    Invoke-Expression "scoop install sudo 7zip git which --global"
    [environment]::SetEnvironmentVariable('GIT_SSH', (resolve-path (scoop which ssh)), 'USER')
    Write-Log "Git installed." -Color "Green"
}
else {
    Write-Log "Git already installed." -Color "Green"
}

### Pull the WinFiles repo from GitHub
if (-not (Test-Path "$winfilesRoot\README.md")) {
    Write-Log "Winfiles missing, preparing to clone"

    Invoke-Expression "git clone --recurse-submodules https://github.com/brennanfee/winfiles.git `"$winfilesRoot`""

    Write-Log "Finished cloning winfiles." -Color "Green"
}
else {
    Write-Log "Winfiles already set up." -Color "Green"
}

Invoke-Expression "$winfilesRoot\01-setup-profile.ps1"
