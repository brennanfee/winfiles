#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator

Import-Module -DisableNameChecking "$PSScriptRoot\scripts\Utilities\AppInstaller.psm1"

Write-Host "Install Apps With Chocolatey" -foreground "green"

choco install -y "$PSScriptRoot/chocolatey-packages-dev.config"

Write-Host "Install Apps - Automatic" -foreground "green"

### On Dev Machines Only
### TODO: Install Docker
### TODO: Install Visual Studio
### TODO: Install Jetbrains Toolbox
### TODO: Install GhostDocPro
### TODO: Install OzCode
### TODO: Install SqlServer ? should switch to using docker for this
### TODO: Install SqlServer Management Studio
### TODO: Install TypeScript
### TODO: Install dotnet core sdk
