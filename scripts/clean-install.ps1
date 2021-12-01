#!/usr/bin/env powershell.exe
#Requires -Version 5
#Requires -RunAsAdministrator
#Requires -PSEdition Desktop
param (
    [ValidateSet('main', 'develop', 'local')]
    [string] $Branch = "main"
)

Set-StrictMode -Version 2.0

# BAF - The purpose of this script is to do the minimum necessary to pull my WinFiles repository onto the current machine while remaining consistent with the rest of the setup script(s).  Ideally, this is being done on a completely clean installation of Windows.
#
# The "WinFiles" are like Linux "dotfiles" but for Windows.
#

# Note, this may need to be run BEFORE this script
Set-ExecutionPolicy Bypass -Scope Process -Force -ErrorAction Ignore

$scriptName = $MyInvocation.MyCommand.Name
Write-Host "Brennan Fee's WinFiles Pull Script - $scriptName" -ForegroundColor "Green"
Write-Host ""
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-Host "Clean Install script started - $date" -ForegroundColor "Magenta"
Write-Host ""

$tempPath = [System.IO.Path]::GetTempPath()

# WARNING: The order matters, they will be run in this order
$scripts = @(
    "configure-profilePath.ps1"
    "install-winget.ps1"
    "install-powerShellCore.ps1"
    "install-ssh.ps1"
    "install-git.ps1"
    "pull-winfiles.ps1"
)

### Download or copy the scripts to the temp directory
foreach ($script in $scripts) {
    Write-Host ""
    $outputFile = Join-Path -Path $tempPath -ChildPath $script

    if ($Branch -eq "local") {
        $localPath = "./$script"

        Copy-Item -Path $localPath -Destination $outputFile
    }
    else {
        ### Remote, so download the script
        $url = "https://raw.githubusercontent.com/brennanfee/winfiles/$Branch/scripts/$script"

        Invoke-WebRequest -Uri $url -OutFile $outputFile
    }
}

### Run the scripts, in order
foreach ($script in $scripts) {
    $fullScript = Join-Path -Path $tempPath -ChildPath $script

    if ($script -eq "pull-winfiles.ps1" -and $Branch -ne "local") {
        & "$fullScript" -Branch $Branch
    }
    else {
        & "$fullScript"
    }

    Remove-Item -Path $fullScript -ErrorAction SilentlyContinue
}

### Now that the Winfiles repo has been pulled we no longer need use the temp directory but instead use the profile path and the Winfiles scripts directly

### Check for and install Firefox if necessary
& "$env:PROFILEPATH\winfiles\scripts\install-firefox.ps1"

### Finally, ensure the system type is set
& "$env:PROFILEPATH\winfiles\shared\set-system-type.ps1"

Write-Host ""
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-Host "Pull script finished - $date" -ForegroundColor "Magenta"
Write-Host ""

Set-Location "$env:PROFILEPATH\winfiles"
Write-Host ""
Write-Host "WinFiles are ready" -ForegroundColor "Green"
Write-Host ""
Write-Host "You will need to close and re-open PowerShell to continue." -ForegroundColor "Yellow"
Write-Host "Once reloaded as admin you can run .\01-setup-profile.ps1" -ForegroundColor "Yellow"
Write-Host ""
