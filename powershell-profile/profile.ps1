#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

$WinFilesFolder = Split-Path -Path "$PSScriptRoot" -Parent

if (-not ("$env:PSModulePath".Contains("$WinFilesFolder\powershell-modules"))) {
    $env:PSModulePath = "$WinFilesFolder\powershell-modules;" + "$env:PSModulePath"
}

Write-Host -ForegroundColor 'Green' "Importing third-party modules..."
# Manually import these
Import-Module PSReadLine
Import-Module Pscx -arg "$PSScriptRoot\Pscx.UserPreferences.ps1"
Import-Module posh-git

# posh-git settings
#$global:GitPromptSettings.EnableWindowTitle = $true
#$global:GitPromptSettings.DefaultForegroundColor = "white"

Write-Host "Modules imported."

# Aliases.  These are here because it seems a module can't export an alias
# that overrides a built-in alias.
Set-Alias ls Get-ListingWslLs -Force -Option AllScope
Set-Alias sl Get-ListingWslLs -Force -Option AllScope
Set-Alias dir Get-ListingWslLla -Force -Option AllScope

# Add the HOME environment variables if not already set
# TODO: Should this move to the bootstrap?
if ([string]::IsNullOrEmpty($env:HOME)) {
    $provider = get-psprovider FileSystem
    $provider.Home = $env:userprofile
    [environment]::SetEnvironmentVariable('HOME', "$env:userprofile", 'User')
    $env:home = $env:userprofile
    Set-Variable -name HOME -value $env:home -Force
}

# Add the EDITOR environment variables if not already set
if ([string]::IsNullOrEmpty($env:EDITOR))
{
    Set-DefaultEditor
}
$Pscx:Preferences['TextEditor'] = $env:EDITOR

Init-PsHistory
