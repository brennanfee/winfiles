#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

$computerDetails = Get-ComputerDetails

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
$key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Services"
Set-RegistryInt "$key\7971F918-A847-4430-9279-4A52D1EFE18D" "RegisteredWithAU" 1

# Turn on notifications for need to restart to finish updates
$key = "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"
Set-RegistryInt "$key" "RestartNotificationsAllowed2" 1
