#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

# NOTE: This is NOT a complete group of settings regarding TLS.  This is just the bare minimum needed to reliably get Winget to work in the early stages of setup.  During the rest of provisioning, a more complete script with more comprehensive settings will be called.

Write-Host "Configurationg User TLS Settings" -ForegroundColor "Green"

$key = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings"
$null = New-Item $key -Force -ErrorAction SilentlyContinue

$null = New-ItemProperty -Path $key -Name 'SecureProtocols' -Value '2048' -PropertyType 'DWord' -Force -ErrorAction SilentlyContinue

$null = New-ItemProperty -Path $key -Name 'EnableHttp1_1' -Value '1' -PropertyType 'DWord' -Force -ErrorAction SilentlyContinue

$null = New-ItemProperty -Path $key -Name 'EnableHTTP2' -Value '1' -PropertyType 'DWord' -Force -ErrorAction SilentlyContinue
