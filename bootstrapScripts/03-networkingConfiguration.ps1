#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Configuring Networking." -ForegroundColor "Green"

# Turn off the thing that prompts whether a network is private or public
& reg.exe add "HKLM\System\CurrentControlSet\Control\Network\NewNetworkWindowOff"

# WinRM
& "$PSScriptRoot\..\scripts\enable-winrm.ps1"

# RDP
& "$PSScriptRoot\..\scripts\enable-rdp.ps1"

Write-Host "Networking configured"
Write-Host ""
