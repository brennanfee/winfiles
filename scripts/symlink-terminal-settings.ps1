#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

######## Microsoft Terminal

$winfiles = Join-Path -Path "$env:PROFILEPATH" -ChildPath "winfiles"

$statePath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
if (-not (Test-Path $statePath)) {
    $null = New-Item -ItemType Directory -Force -Path $statePath
}

Remove-Item -Path "$statePath\settings.json" -ErrorAction SilentlyContinue

New-SymbolicLink "$statePath\settings.json" "$winFiles\settings\windows-terminal-settings.json"
