#!/usr/bin/env powershell.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Set-ExecutionPolicy RemoteSigned -scope LocalMachine -Force
Set-ExecutionPolicy Unrestricted -scope CurrentUser -Force

### Determine how many fixed disks we have
$DriveCount = (Get-PhysicalDisk | Measure-Object).Count

$profilesPath="C:\profile"
if ($DriveCount -ge 2) {
    $profilesPath="D:\profile"
}
$winfilesRoot="$profilesPath\winfiles"

### Phase 1 - If the winfiles are not there, pull them from GitHub
if (!(Test-Path "$winfilesRoot\README.md")) {
    # Check if scoop is already installed
    if (-not (Test-Path "$profilesPath\scoop\shims\scoop")) {
        [environment]::setEnvironmentVariable('SCOOP', "$profilesPath\scoop", 'User')
        $env:SCOOP="$profilesPath\scoop"
        [environment]::setEnvironmentVariable('SCOOP_GLOBAL','C:\scoop-global','Machine')
        $env:SCOOP_GLOBAL='C:\scoop-global'

        # Install scoop
        iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
    }

    # Check if git is already installed
    if (-not (Test-Path "$env:USERPROFILE\scoop\shims\git.exe")) {
        # Install git
        scoop install sudo 7zip git --global
        [environment]::setenvironmentvariable('GIT_SSH', (resolve-path (scoop which ssh)), 'USER')
    }

    # Pull the repo
    git clone --recurse-submodules "https://github.com/brennanfee/winfiles.git" "$winfilesRoot"

    Write-Host -ForegroundColor 'Green' "Finished downloading winfiles."
} else {
    Write-Host -ForegroundColor 'Green' "Winfiles already set up."
}

## Now run the "admin" setup script
