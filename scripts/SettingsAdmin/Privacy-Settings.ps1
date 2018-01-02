#!/usr/bin/env powershell.exe
#Requires -Version 4
#Requires -RunAsAdministrator

Import-Module -DisableNameChecking "$PSScriptRoot\..\Utilities\FileAndRegistryUtilities.psm1"

# Turn off Telemetry (set to Basic)
Set-RegistryInt "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" "AllowTelemetry" 1
