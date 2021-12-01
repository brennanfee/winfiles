#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
param (
    [switch] $Force = $false
)

Set-StrictMode -Version 2.0

$wingetCmd = (Get-Command -Name winget.exe -ErrorAction SilentlyContinue)
if ($wingetCmd) {
    $wingetExe = "$($wingetCmd.Source)"
}
else {
    $wingetExe = Join-Path -Path "$env:LOCALAPPDATA" -ChildPath "Microsoft\WindowsApps\winget.exe"
}
if (-not (Test-Path -Path "$wingetExe")) {
    throw "Unable to locate WinGet, it must be installed first before this script will function."
}

Write-Host "Checking for Git..." -ForegroundColor "Green"

if (-not (Test-Path "C:\Program Files\Git\cmd\git.exe") -or $Force) {
    Write-Host "Git missing, preparing for install using WinGet."

    Write-Host ""
    & "$wingetExe" install Git.Git --silent --accept-package-agreements --accept-source-agreements --override "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /NOICONS /GitOnlyOnPath /NoAutoCrlf /WindowsTerminal /NoShellIntegration /NoOpenSSH /Symlinks"

    Write-Host "Git installed." -ForegroundColor "Cyan"
}
else {
    Write-Host "Git already installed." -ForegroundColor "Cyan"
}

Write-Host "Configuring GIT_SSH environment variable."

$sshPath = "C:\Program Files\Git\usr\bin\ssh.exe"
$openSshPath = "C:\Windows\System32\OpenSSH\ssh.exe"
if (Test-Path -Path $openSshPath) {
    $sshPath = $openSshPath
}

[environment]::SetEnvironmentVariable('GIT_SSH', $sshPath, 'USER')
$env:GIT_SSH = $sshPath

Write-Host ""
