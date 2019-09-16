#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

######## Microsoft Terminal

$statePath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
if (-not (Test-Path $statePath)) {
    New-Item -ItemType Directory -Force -Path $statePath | Out-Null
}

Remove-Item -Path "$statePath\profiles.json" -ErrorAction SilentlyContinue

New-SymbolicLink "$statePath\profiles.json" "$winFiles\settings\profiles.json"

