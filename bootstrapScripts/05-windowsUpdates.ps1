#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

$computerDetails = Get-ComputerDetails

Write-Host "Configuring Windows Updates" -ForegroundColor "Green"

# Set the "active hours" for windows updates
if ($computerDetails.WinReleaseId -ge 1903) {
    # Just turn on the "Smart Active Hours State" feature
    $updateKey = "HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings"
    Set-RegistryInt "$updateKey" "SmartActiveHoursState" 1
}
else {
    # Set the start and end hours
    $updateKey = "HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings"
    Set-RegistryInt "$updateKey" "ActiveHoursStart" 8
    Set-RegistryInt "$updateKey" "ActiveHoursEnd" 22
}

# Turn on getting updates for Microsoft products
$updateRegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update"
Set-RegistryInt "$updateRegPath" "EnableFeaturedSoftware" 1
Set-RegistryInt "$updateRegPath" "IncludeRecommendedUpdates" 1

# Turn on notifications for need to restart to finish updates
$key = "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"
Set-RegistryInt "$key" "RestartNotificationsAllowed2" 1

# ServiceManager entry
$mu = New-Object -ComObject Microsoft.Update.ServiceManager -Strict
$mu.AddService2("7971f918-a847-4430-9279-4a52d1efe18d", 7, "")

Write-Host "Windows Updates configured"
Write-Host ""
