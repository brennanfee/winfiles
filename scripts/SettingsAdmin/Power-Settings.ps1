#!/usr/bin/env powershell.exe
#Requires -Version 4
#Requires -RunAsAdministrator

Import-Module -DisableNameChecking "$PSScriptRoot\..\Utilities\FileAndRegistryUtilities.psm1"
Import-Module -DisableNameChecking "$PSScriptRoot\..\Utilities\Get-ComputerDetails.psm1"
$computerDetails = Get-ComputerDetails

Write-Host "Setting Power Profile"

if ($computerDetails.IsVirtual)
{
    # Set to "High Performance" profile
    cmd /c powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    cmd /c powercfg -Change -monitor-timeout-ac 0
    cmd /c powercfg -Change -monitor-timeout-dc 0
    cmd /c powercfg -Change -disk-timeout-ac 0
    cmd /c powercfg -Change -disk-timeout-dc 0

    Write-Host "Disabling Hibernation"
    Set-RegistryInt "HKLM:\System\CurrentControlSet\Control\Power" "HibernateFileSizePercent" 0
    Set-RegistryInt "HKLM:\System\CurrentControlSet\Control\Power" "HibernateEnabled" 0
}
else
{
    # Set to "Balanced" profile
    cmd /c powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e
    if ($computerDetails.IsLaptop)
    {
        #TODO: Tweak these to be appropriate for laptops

        # Turn of monitor after 45 minutes
        cmd /c powercfg -Change -monitor-timeout-ac 60
        cmd /c powercfg -Change -monitor-timeout-dc 60
        # Spin down disk after 20 minutes
        cmd /c powercfg -Change -disk-timeout-ac 20
        cmd /c powercfg -Change -disk-timeout-dc 20
        # Go to sleep after 4 hours (240 minutes)
        cmd /c powercfg -Change -standby-timeout-ac 240
        cmd /c powercfg -Change -standby-timeout-dc 240
    }
    else
    {
        # Machine is a desktop

        # Turn of monitor after 45 minutes
        cmd /c powercfg -Change -monitor-timeout-ac 60
        cmd /c powercfg -Change -monitor-timeout-dc 60
        # Spin down disk after 20 minutes
        cmd /c powercfg -Change -disk-timeout-ac 20
        cmd /c powercfg -Change -disk-timeout-dc 20
        # Go to sleep after 4 hours (240 minutes)
        cmd /c powercfg -Change -standby-timeout-ac 240
        cmd /c powercfg -Change -standby-timeout-dc 240
    }
}

# Set "active" hours for Windows Update, 8 am to 11pm
$updateKey = "HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings"
Set-RegistryInt "$updateKey" "ActiveHoursStart" 8
Set-RegistryInt "$updateKey" "ActiveHoursEnd" 23
