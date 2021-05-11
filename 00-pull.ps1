#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
#Requires -PSEdition Desktop
Set-StrictMode -Version 2.0

# BAF - The purpose of this script is to do the minimum necessary to pull
# my WinFiles repository onto the current machine.  The "WinFiles" are like
# Linux "dotfiles" but for Windows.  It is intended that this script be run
# directly from the web from the command line without any prior setup for
# the machine.  Use one of these command:
#    Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -Uri 'https://git.io/fjBQX').Content)
#    iex ((iwr -UseBasicParsing -Uri 'https://git.io/fjBQX').Content)

# Note, this may need to be run BEFORE this script
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force -ErrorAction Ignore

### Set Profile location (based on how many disks we have)
### 1 disk means porfile is in C:\profile, 2 disks or more means D:\profile
$driveCount = (Get-PhysicalDisk | Measure-Object).Count

$profilesPath = "C:\profile"
if ($driveCount -ge 2) {
    $profilesPath = "D:\profile"
}
[Environment]::SetEnvironmentVariable("PROFILEPATH", $profilesPath, "User")
$env:PROFILEPATH = $profilesPath
if (-not (Test-Path "$env:PROFILEPATH")) {
    New-Item -ItemType Directory -Force -Path $env:PROFILEPATH | Out-Null
}

Write-Host "Brennan Fee's WinFiles Pull Script" -ForegroundColor "Green"
Write-Host ""
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-Host "Pull script started - $date"

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

Set-Location "$env:PROFILEPATH\winfiles"
Write-Host "WinFiles are ready" -ForegroundColor "Green"
Write-Host ""
Write-Host "You will need to close and re-open PowerShell to continue." -ForegroundColor "Yellow"
Write-Host "Once reloaded as admin you can run .\01-setup-profile.ps1" -ForegroundColor "Yellow"

$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-Host "Pull script finished - $date"
Write-Host ""
