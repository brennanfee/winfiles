#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Installing game applications using AppGet - Main"
$apps = @(
    "gog-galaxy"
    "steam"
    "uplay"
    "epic-games-launcher"
    "twitch"
    "battlenet"  # Shows prompts during install
    "origin"  # Shows prompts during install
)

foreach ($app in $apps) {
    Install-WithAppGet $app
}
