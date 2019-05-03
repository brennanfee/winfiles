#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

$winfilesRoot = "$env:USERPROFILE\winfiles"

Set-ExecutionPolicy RemoteSigned -scope CurrentUser

### Phase 1 - If the winfiles are not there, pull them from GitHub
if (!(Test-Path "$winfilesRoot\README.md")) {
    # Check if scoop is already installed
    if (!(Test-Path "$env:USERPROFILE\scoop\shims\scoop")) {
        # Install scoop
        iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
    }

    # Check if git is already installed
    if (!(Test-Path "$env:USERPROFILE\scoop\shims\git.exe")) {
        # Install git
        scoop install git
    }

    # Pull the repo
    git clone --recurse-submodules "https://github.com/brennanfee/winfiles.git" "$env:USERPROFILE\winfiles"

    Write-Output "Finished downloading winfiles."
}
