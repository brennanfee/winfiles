#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Post install configurations" -ForegroundColor "Green"

########  Path Environment Variables
Write-Host "Updating Paths"

if (Test-Path "$env:APPDATA\Python\Python39\Scripts") {
    Add-ToPath "$env:APPDATA\Python\Python39\Scripts"
}
elseif (Test-Path "$env:APPDATA\Python\Python38\Scripts") {
    Add-ToPath "$env:APPDATA\Python\Python38\Scripts"
}
elseif (Test-Path "$env:APPDATA\Python\Python37\Scripts") {
    Add-ToPath "$env:APPDATA\Python\Python37\Scripts"
}

if (Test-Path "$env:PROFILEPATH\cloud\win-bin") {
    Add-ToPath "$env:PROFILEPATH\cloud\win-bin"
}

######## Symlink Settings
& "$PSScriptRoot\..\scripts\symlink-winget-settings.ps1"
& "$PSScriptRoot\..\scripts\symlink-terminal-settings.ps1"
