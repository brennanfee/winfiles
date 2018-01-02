#!/usr/bin/env powershell.exe
#Requires -Version 4
#Requires -RunAsAdministrator

Import-Module -DisableNameChecking "$PSScriptRoot\..\Utilities\FileAndRegistryUtilities.psm1"

$fontkey = 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Console'

Set-RegistryString "$fontkey\TrueTypeFont" "000" "Hack NF"
Set-RegistryString "$fontkey\TrueTypeFont" "0000" "Hasklig NF"
Set-RegistryString "$fontkey\TrueTypeFont" "00000" "SourceCodePro NF"
