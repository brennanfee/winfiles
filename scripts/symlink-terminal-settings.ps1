#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

######## Microsoft Terminal

$winfiles = "$env:PROFILEPATH\winfiles"

$statePath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
if (-not (Test-Path $statePath)) {
    $null = New-Item -ItemType Directory -Force -Path $statePath
}

Remove-Item -Path "$statePath\profiles.json" -ErrorAction SilentlyContinue

New-SymbolicLink "$statePath\profiles.json" "$winFiles\settings\windows-terminal-settings.json"
