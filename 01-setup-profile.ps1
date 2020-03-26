#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
#Requires -PSEdition Desktop
Set-StrictMode -Version 2.0

# Note, this may need to be run BEFORE this script
Set-ExecutionPolicy Bypass -Scope Process -Force -ErrorAction Ignore

function Is64Bit { [IntPtr]::Size -eq 8 }

Invoke-Expression -command "$PSScriptRoot\shared\set-system-type.ps1"

$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-Host "Setup Profile script started - $date"
Write-Host "System type: $env:SYSTEMTYPE"
Write-Host ""

$executionPolicyBlock = {
    Set-ExecutionPolicy Unrestricted -scope Process -Force -ErrorAction Ignore
    Set-ExecutionPolicy Unrestricted -scope LocalMachine -Force -ErrorAction Ignore
    Set-ExecutionPolicy Unrestricted -scope CurrentUser -Force -ErrorAction Ignore
}

$arguments = "-NoProfile -NonInteractive -ExecutionPolicy Unrestricted " +
"-Command $executionPolicyBlock"

if (Is64Bit) {
    Start-Process -Wait -NoNewWindow -ArgumentList $arguments `
        -FilePath "$env:SystemRoot\SysWOW64\WindowsPowerShell\v1.0\powershell.exe"
}

Start-Process -Wait -NoNewWindow -FilePath "powershell.exe" -ArgumentList $arguments

# Install Nuget provider if needed
$providers = Get-PackageProvider | Select-Object Name
if (-not ($providers.Contains("nuget"))) {
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force | Out-Null
}

$moduleBlock = {
    Write-Host "Setting up PowerShell repositories"
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

    Write-Host "Upgrading built-in modules"
    Install-Module -Name PackageManagement -Scope AllUsers -Force
    Install-Module -Name PowerShellGet -Scope AllUsers -Force
    Install-Module -Name Pester -Scope AllUsers -Force -SkipPublisherCheck

    Write-Host "Updating modules"
    Update-Module -ErrorAction SilentlyContinue

    # Only the minimum necessary modules to make the profile work
    Write-Host "Installing modules"
    Install-Module -Name Pscx -AllowClobber -Scope CurrentUser -Force
}

Invoke-Command -ScriptBlock $moduleBlock

# Prepend the WinFiles modules folder to the module search path
$winfilesRoot = $PSScriptRoot
if (-not ("$env:PSModulePath".Contains("$winfilesRoot\powershell-modules"))) {
    $env:PSModulePath = "$winfilesRoot\powershell-modules;" + "$env:PSModulePath"
}

Write-Host "Importing modules"
Import-Module SystemUtilities
Import-Module MyCustomProfileUtilities

# Setup the profile environment variable
Write-Host "Setting profile location"
Set-MyCustomProfileLocation

$logFile = "$env:PROFILEPATH\logs\winfiles\setup-profile.log"

Write-Log $logFile "----------"
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-LogAndConsole $logFile "Profile script log started - $date"
Write-LogAndConsole $logFile  "System type: $env:SYSTEMTYPE"
Write-LogAndConsole $logFile ""

Write-LogAndConsole $logFile "Installing posh-git"
$installPoshGit = "Install-Module -Name posh-git -AllowClobber -Scope CurrentUser " +
"-AllowPrerelease -Force"

Invoke-ExternalPowerShell -Command $installPoshGit

Write-LogAndConsole $logFile "Symlinking profile into place"

# First the traditional powershell profile
New-SymbolicLink $PROFILE "$winfilesRoot\powershell-profile\profile.ps1" -Force

# Also symlink for the Nuget profile
# TODO: Originally this was used by Visual Studio, not sure if VS 2017\2019
# still uses this or standard powershell.  Validate that this is still needed.
$profileLocation = Split-Path -Path $PROFILE -Parent
$nugetFile = Join-Path $profileLocation "NuGet_profile.ps1"

New-SymbolicLink $nugetFile "$winfilesRoot\powershell-profile\profile.ps1" -Force

# Install Chocolatey if needed
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

# Install PowerShell Core if needed
Write-Host "Checking for PowerShell Core"
$psCoreExe = "C:\Program Files\PowerShell\7\pwsh.exe"
if (-not (Test-Path "$psCoreExe")) {
    Write-LogAndConsole $logFile "Installing PowerShell Core"

    Invoke-Expression "&C:\ProgramData\Chocolatey\bin\choco.exe install -y -r powershell-core --installarguments `"/quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1`""

    Write-LogAndConsole $logFile "PowerShell Core installed" -Color "Green"
}
else {
    Write-LogAndConsole $logFile "PowerShell Core already installed" -Color "Green"
}

Write-LogAndConsole $logFile "Setting PowerShell Core permissions"
Invoke-ExternalPowerShellCore $executionPolicyBlock

Write-LogAndConsole $logFile "Installing modules for PowerShell Core"
Invoke-ExternalPowerShellCore $moduleBlock

Write-LogAndConsole $logFile "Installing posh-git for PowerShell Core"
Invoke-ExternalPowerShellCore $installPoshGit

# Profile for PowerShell Core
Write-LogAndConsole $logFile "Symlinking profile for PowerShell Core"
$myDocsFolder = [Environment]::GetFolderPath("MyDocuments")
$psCoreProfile = "$myDocsFolder\PowerShell\Microsoft.PowerShell_profile.ps1"
New-SymbolicLink $psCoreProfile "$winfilesRoot\powershell-profile\profile.ps1" -Force

Write-LogAndConsole $logFile "Powershell profile setup complete" -Color "Green"
Write-Host ""
Write-LogAndConsole $logFile -Color "Yellow" `
    "You will need to close and re-open PowerShell to continue."
Write-LogAndConsole $logFile -Color "Yellow" `
    "Once reloaded as admin you can run .\02-bootstrap.ps1"
Write-Host ""
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-LogAndConsole $logFile "Script Complete - $date" -Color "Green"
