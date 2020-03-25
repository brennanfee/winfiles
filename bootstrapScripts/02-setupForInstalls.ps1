#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

# Setup "extras" repo for scoop
Write-Host "Setting up scoop buckets"

Add-ScoopBucket "main"
Add-ScoopBucket "extras"
Add-ScoopBucket "nerd-fonts"

Write-Host "Scoop buckets configured"

Write-Host "Setting up Chocolatey features"
Invoke-Expression "choco feature enable -n=useRememberedArgumentsForUpgrades"
Invoke-Expression "choco feature enable -n=skipPackageUpgradesWhenNotInstalled"
#Invoke-Expression "choco feature enable -n=ignoreUnfoundPackagesOnUpgradeOutdated"
