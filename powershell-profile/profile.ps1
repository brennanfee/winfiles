#!/usr/bin/env pwsh
#Requires -Version 5
Set-StrictMode -Version 2.0

$winFilesFolder = Join-Path -Path $env:PROFILEPATH -ChildPath "winfiles"

if (-not ("$env:PSModulePath".Contains("$winFilesFolder\powershell-modules"))) {
    $env:PSModulePath = "$winFilesFolder\powershell-modules;" + "$env:PSModulePath"
}

Write-Host -ForegroundColor 'Green' "Importing third-party modules..."
# Manually import these
Import-Module PSReadLine
Import-Module Pscx -arg "$winFilesFolder\powershell-profile\Pscx.UserPreferences.ps1"
Import-Module posh-git

Import-Module SystemUtilities
Import-Module MyCustomProfileUtilities
Import-Module PsHistory

# A workaround for a little bug in PowerShell Core.  It currently can't load the Appx package by itself
if ($PSEdition -eq "Core") {
    Import-Module -Name Appx -UseWindowsPowershell -WarningAction SilentlyContinue
}

# posh-git settings
#$global:GitPromptSettings.EnableWindowTitle = $true
#$global:GitPromptSettings.DefaultForegroundColor = "white"

Write-Host "Modules imported."

# Aliases.  These are here because it seems a module can't export an alias
# that overrides a built-in alias.
Set-Alias ls Get-ListingWslLs -Force -Option AllScope
Set-Alias sl Get-ListingWslLs -Force -Option AllScope
Set-Alias dir Get-ListingWslLla -Force -Option AllScope
Set-Alias curl curl.exe -Force -Option AllScope
Set-Alias gc Invoke-GitCommit -Force -Option AllScope
Set-Alias gl Invoke-GitLog -Force -Option AllScope

# Add the EDITOR environment variables if not already set
if ([string]::IsNullOrEmpty($env:EDITOR)) {
    Set-DefaultEditor
}
$Pscx:Preferences['TextEditor'] = $env:EDITOR

Initialize-PsHistory

function prompt {
    return Get-CustomPrompt
}
