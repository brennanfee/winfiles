#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Setting up PowerShell repositories"
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

Write-Host "Updating modules"
Update-Module -ErrorAction SilentlyContinue

Write-Host "Installing modules"
Install-Module -Name Pscx -AllowClobber -Scope CurrentUser
Install-Module -Name posh-git -AllowClobber -Scope CurrentUser
Install-Module -Name posh-docker -Scope CurrentUser
