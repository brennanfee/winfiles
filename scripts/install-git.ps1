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

    # GitPullBehaviorOption options: Merge, FFOnly, Rebase

    $infTest = @"
[Setup]
Lang=default
Dir=C:\Program Files\Git
Group=Git
NoIcons=1
SetupType=default
Components=gitlfs
Tasks=
EditorOption=VIM
CustomEditorPath=
DefaultBranchOption=main
PathOption=Cmd
SSHOption=ExternalOpenSSH
TortoiseOption=false
CURLOption=OpenSSL
CRLFOption=CRLFCommitAsIs
BashTerminalOption=ConHost
GitPullBehaviorOption=FFOnly
UseCredentialManager=Enabled
PerformanceTweaksFSCache=Enabled
EnableSymlinks=Enabled
EnablePseudoConsoleSupport=Disabled
EnableFSMonitor=Disabled
"@

    $tempPath = [System.IO.Path]::GetTempPath()
    $infFile = Join-Path -Path $tempPath -ChildPath "git.inf"
    $infTest | Out-File -FilePath $infFile

    Write-Host ""
    & "$wingetExe" install Git.Git --silent --accept-package-agreements --accept-source-agreements --override "/SILENT /SUPPRESSMSGBOXES /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /NOICONS /LOADINF=`"$infFile`""

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
