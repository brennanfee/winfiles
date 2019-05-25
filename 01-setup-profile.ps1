#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
#Requires -PSEdition Desktop
Set-StrictMode -Version 2.0

# Note, this may need to be run BEFORE this script
Set-ExecutionPolicy Unrestricted -scope CurrentUser -Force -ErrorAction Ignore

function Is64Bit { [IntPtr]::Size -eq 8 }

$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
Write-Host "Setup Profile script started - $date"
Write-Host ""

$executionPolicyBlock = {
    Set-ExecutionPolicy Unrestricted -scope LocalMachine -Force -ErrorAction Ignore
    Set-ExecutionPolicy Unrestricted -scope CurrentUser -Force -ErrorAction Ignore
}

if (Is64Bit) {
    $arguments = "-NoProfile -NonInteractive -ExecutionPolicy Unrestricted " +
    "-Command $executionPolicyBlock"
    Start-Process -Wait -NoNewWindow -ArgumentList $arguments `
        -FilePath "$env:SystemRoot\SysWOW64\WindowsPowerShell\v1.0\powershell.exe"
}

$arguments = "-NoProfile -NonInteractive -ExecutionPolicy Unrestricted " +
"-Command $executionPolicyBlock"
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

$installPoshGit = "Install-Module -Name posh-git -AllowClobber -Scope CurrentUser " +
"-AllowPrerelease -Force"

Invoke-ExternalPowerShell -Command $installPoshGit

# Setup the profile environment variable
Set-MyCustomProfileLocation

$logFile = "$env:ProfilePath\logs\winfiles\setup-profile.log"
if ($PSVersionTable.PSEdition -eq "Core") {
    $logFile = "$env:ProfilePath\logs\winfiles\setup-profile-core.log"
}

Write-Log $logFile "----------"
Write-LogAndConsole $logFile "Profile script log started"
Write-LogAndConsole $logFile "PowerShell Edition: $PSVersionTable.PSEdition"
Write-LogAndConsole $logFile ""

Write-LogAndConsole $logFile "Symlinking profile into place"

# First the traditional powershell profile
New-SymbolicLink $PROFILE "$winfilesRoot\powershell-profile\profile.ps1" -Force

# Also symlink for the Nuget profile
# TODO: Originally this was used by Visual Studio, not sure if VS 2017\2019
# still uses this or standard powershell.  Validate that this is still needed.
$profileLocation = Split-Path -Path $PROFILE -Parent
$nugetFile = Join-Path $profileLocation "NuGet_profile.ps1"

New-SymbolicLink $nugetFile "$winfilesRoot\powershell-profile\profile.ps1" -Force

# Install PowerShell Core if needed
Write-Host "Checking for PowerShell Core"
$psCoreExe = "$env:ProgramFiles\PowerShell\6\pwsh.exe"
if (-not (Test-Path "$psCoreExe")) {
    Write-LogAndConsole $logFile "Installing PowerShell Core"

    $msiLogFile = "$env:ProfilePath\logs\winfiles\pwsh-install.log"
    $msiArguments = @(
        "ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1"
        "ENABLE_PSREMOTING=1"
        "REGISTER_MANIFEST=1"
    )

    Invoke-MsiInstaller "$winfilesRoot\installs\PowerShell.msi" $msiLogFile `
        $msiArguments

    Write-LogAndConsole $logFile "Setting PowerShell Core permissions"
    Invoke-ExternalPowerShellCore $executionPolicyBlock

    Write-LogAndConsole $logFile "Installing modules for PowerShell Core"
    Invoke-ExternalPowerShellCore $moduleBlock

    Invoke-ExternalPowerShellCore $installPoshGit
}
else {
    Write-LogAndConsole $logFile "PowerShell Core already installed" -Color "Green"
}

# Profile for PowerShell Core
$myDocsFolder = [Environment]::GetFolderPath("MyDocuments")
$psCoreProfile = "$myDocsFolder\PowerShell\Microsoft.PowerShell_profile.ps1"
New-SymbolicLink $psCoreProfile "$winfilesRoot\powershell-profile\profile.ps1" -Force

# Install AppGet
Write-Host "Checking for AppGet"
if (-not (Test-Path "C:\ProgramData\AppGet\bin\appget.exe")) {
    Write-Host "Installing AppGet"
    $logFile = "$env:ProfilePath\logs\winfiles\appget-install.log"
    $command = "$winfilesRoot\installs\appget.exe /VERYSILENT " +
    "/SUPPRESSMSGBOXES /SP `"/LOG=$logFile`""

    Invoke-Expression -command $command
}
else {
    Write-Host "AppGet already installed"
}

Write-LogAndConsole $logFile "Profile setup complete" -Color "Green"
Write-Host ""
Write-LogAndConsole $logFile -Color "Yellow" `
    "You will need to close and re-open PowerShell to continue."
Write-Host ""
Write-LogAndConsole $logFile "Complete" -Color "Green"
