#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

$computerDetails = Get-ComputerDetails

# Set the "active hours" for windows updates
if ($computerDetails -ge 1903) {
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
