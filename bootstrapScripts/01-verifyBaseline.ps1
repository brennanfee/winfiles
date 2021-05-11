#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

# This script verifies the baseline and corrects what is needed.
# It is ALWAYS expected that users run 01-setup-profile.ps1 but not
# necessarily 00-pull.ps1.  This will cover the situation where they did
# skip 00-pull.ps1.  As a result, there is some code duplication between
# this script and 00-pull.ps1.  Changes to 00-pull.ps1 may need to be copied
# to here.

Write-Host "Verifying baseline"

# Setup the profile environment variable
Write-Host "Setting profile location"
Set-MyCustomProfileLocation -Force

# Check if Chocolatey is already installed
if (-not (Test-Path "C:\ProgramData\Chocolatey\bin\choco.exe")) {
    Write-Host "Chocolatey missing, preparing for install"

    Invoke-Expression (
        (Invoke-WebRequest -UseBasicParsing -Uri 'https://chocolatey.org/install.ps1').Content
    )

    New-Item -Path "C:\ProgramData\Chocolatey\license" -Type Directory -Force | Out-Null
}
else {
    Write-Host "Chocolatey is already installed." -ForegroundColor "Green"
}

# Check if git is already installed
if (-not (Test-Path "C:\Program Files\Git\cmd\git.exe")) {
    Write-Host "Git missing, preparing for install using Chocolatey."

    Write-Host ""
    Invoke-Expression "&C:\ProgramData\Chocolatey\bin\choco.exe install -y -r git --params `"/GitOnlyOnPath /NoAutoCrlf /WindowsTerminal /NoShellIntegration`""

    $sshPath = "C:\Program Files\Git\usr\bin\ssh.exe"
    if ((Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Client*').State -eq "Installed") {
        $sshPath = "C:\Windows\System32\OpenSSH\ssh.exe"
    }

    [environment]::SetEnvironmentVariable('GIT_SSH', $sshPath, 'USER')
    $env:GIT_SSH = $sshPath

    Write-Host "Git installed." -ForegroundColor "Green"
}
else {
    Write-Host "Git already installed." -ForegroundColor "Green"
}

# I know it might look odd to check for pulling the Winfiles repo.  But,
# while the user is obviously running these files from within a copy of the Winfiles,
# there is no gaurantee they are in the right location or that they pulled it using Git.

### Pull the WinFiles repo from GitHub
if (-not (Test-Path "$env:PROFILEPATH\winfiles\README.md")) {
    Write-Host "Winfiles missing, preparing to clone"

    Write-Host ""
    Invoke-Expression "&`"C:\Program Files\Git\cmd\git.exe`" clone --recurse-submodules https://github.com/brennanfee/winfiles.git `"$env:PROFILEPATH\winfiles`""
    Write-Host ""

    Write-Host "Finished cloning winfiles." -ForegroundColor "Green"
}
else {
    Write-Host "Winfiles already set up." -ForegroundColor "Green"
}

Invoke-Expression -command "$env:PROFILEPATH\winfiles\shared\set-system-type.ps1"
