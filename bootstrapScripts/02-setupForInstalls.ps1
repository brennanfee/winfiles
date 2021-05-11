#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Setting up Chocolatey features"
Invoke-Expression "choco feature enable -n=useRememberedArgumentsForUpgrades"
Invoke-Expression "choco feature enable -n=skipPackageUpgradesWhenNotInstalled"
#Invoke-Expression "choco feature enable -n=ignoreUnfoundPackagesOnUpgradeOutdated"
