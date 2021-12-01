#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Installing Developer Mode & WSL" -ForegroundColor "Green"

$delay = 15

# Developer Mode
$key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
Set-RegistryInt "$key" "AllowDevelopmentWithoutDevLicense" 1

$extraCapabilities = @(
    "Tools.DeveloperMode.Core~"
)

foreach ($feature in $extraCapabilities) {
    Write-Host ""
    Write-Host "Checking feature: $feature"

    $items = Get-WindowsCapability -Online |
    Where-Object { $_.State -eq "NotPresent" } |
    Where-Object { $_.Name.StartsWith($feature) }

    if ($items) {
        foreach ($item in $items) {
            $name = $item.Name
            Write-Host "Enabling feature: $name"
            $null = Add-WindowsCapability -Online -Name $name
            Start-Sleep $delay
            Write-Host "Feature enabled: $name"
        }
    }
    else {
        Write-Host "Feature '$feature' already enabled"
    }
}

# WSL
$extraFeatures = @(
    "Microsoft-Windows-Subsystem-Linux"
)

foreach ($feature in $extraFeatures) {
    Write-Host ""
    Write-Host "Checking feature: $feature"

    $item = Get-WindowsOptionalFeature -Online -FeatureName $feature
    if ($item -and $item.State -eq "Disabled") {
        Write-Host "Enabling feature: $feature"
        $null = Enable-WindowsOptionalFeature -FeatureName $feature -Online -All -NoRestart
        Start-Sleep $delay
        Write-Host "Feature enabled: $feature"
    }
    else {
        Write-Host "Feature '$feature' is already enabled"
    }
}

Write-Host "Develop Mode & WSL installed"
Write-Host ""
