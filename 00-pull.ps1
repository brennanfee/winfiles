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
[Environment]::SetEnvironmentVariable("ProfilePath", $profilesPath, "User")
$env:ProfilePath = $profilesPath

Write-Host ""
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-Host "Pull script started - $date"

# Check if scoop is already installed
if (-not (Test-Path "$env:ProfilePath\scoop\shims\scoop")) {
    Write-Host "Scoop missing, preparing for install"
    [environment]::SetEnvironmentVariable('SCOOP', "$env:ProfilePath\scoop", 'User')
    $env:SCOOP = "$env:ProfilePath\scoop"
    [environment]::SetEnvironmentVariable('SCOOP_GLOBAL', 'C:\scoop-global', 'Machine')
    $env:SCOOP_GLOBAL = 'C:\scoop-global'

    # Install scoop
    Write-Host ""
    Set-StrictMode -Off # Need to turn StrictMode off because Scoop script has errors
    Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -Uri 'https://get.scoop.sh').Content)
    Set-StrictMode -Version 2.0
    Write-Host ""

    # Scoop configuration
    Add-MpPreference -ExclusionPath $env:SCOOP
    Add-MpPreference -ExclusionPath $env:SCOOP_GLOBAL
    Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1
    scoop config aria2-enabled false

    Write-Host "Scoop installed." -ForegroundColor "Green"
}
else {
    Write-Host "Scoop already installed." -ForegroundColor "Green"
}

# Check if git is already installed
if (-not (Test-Path "$env:SCOOP_GLOBAL\shims\git.exe")) {
    Write-Host "Git missing, preparing for install using scoop."

    Write-Host ""
    Invoke-Expression "scoop install --global sudo 7zip git git-lfs innounp dark which aria2"
    Write-Host ""

    [environment]::SetEnvironmentVariable('GIT_SSH', (resolve-path (scoop which ssh)), 'USER')
    $env:GIT_SSH = (resolve-path (scoop which ssh))
    Write-Host "Git installed." -ForegroundColor "Green"
}
else {
    Write-Host "Git already installed." -ForegroundColor "Green"
}

### Pull the WinFiles repo from GitHub
if (-not (Test-Path "$env:ProfilePath\winfiles\README.md")) {
    Write-Host "Winfiles missing, preparing to clone"

    Write-Host ""
    Invoke-Expression "git clone --recurse-submodules https://github.com/brennanfee/winfiles.git `"$env:ProfilePath\winfiles`""
    Write-Host ""

    Write-Host "Finished cloning winfiles." -ForegroundColor "Green"
}
else {
    Write-Host "Winfiles already set up." -ForegroundColor "Green"
}

Set-Location "$env:ProfilePath\winfiles"
Write-Host "WinFiles are ready, you may now run .\01-setup-profile.ps1" -ForegroundColor "Yellow"

$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-Host "Pull script finished - $date"
Write-Host ""
