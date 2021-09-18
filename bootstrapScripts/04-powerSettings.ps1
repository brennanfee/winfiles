#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Configuring Power Settings" -ForegroundColor "Green"

$computerDetails = Get-ComputerDetails

if ($computerDetails.IsVirtual) {
    Write-Host "Disabling Screensaver"
    Set-RegistryInt "HKCU:\Control Panel\Desktop" "ScreenSaveActive" 0

    # Set to "High Performance" profile
    Write-Host "Setting Power Profile"
    & powercfg.exe -setactive "8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"
    & powercfg.exe -Change -monitor-timeout-ac 0
    & powercfg.exe -Change -monitor-timeout-dc 0
    & powercfg.exe -Change -disk-timeout-ac 0
    & powercfg.exe -Change -disk-timeout-dc 0

    Write-Host "Disabling Hibernation"
    & powercfg.exe /hibernate off
}
else {
    Write-Host "Enabling Screensaver"
    Set-RegistryInt "HKCU:\Control Panel\Desktop" "ScreenSaveActive" 1

    # Resize the hibernate file
    & powercfg.exe -h -size "%50"

    # Set to "Balanced" profile
    & powercfg.exe -setactive "381b4222-f694-41f0-9685-ff5bb260df2e"
    if ($computerDetails.IsLaptop) {
        #TODO: Tweak these to be appropriate for laptops

        # Turn of monitor after 45 minutes
        & powercfg.exe -Change -monitor-timeout-ac 60
        & powercfg.exe -Change -monitor-timeout-dc 60
        # Spin down disk after 20 minutes
        & powercfg.exe -Change -disk-timeout-ac 20
        & powercfg.exe -Change -disk-timeout-dc 20
        # Go to sleep after 4 hours (240 minutes)
        & powercfg.exe -Change -standby-timeout-ac 240
        & powercfg.exe -Change -standby-timeout-dc 240
    }
    else {
        # Machine is a desktop

        # Turn of monitor after 45 minutes
        & powercfg.exe -Change -monitor-timeout-ac 60
        & powercfg.exe -Change -monitor-timeout-dc 60
        # Spin down disk after 20 minutes
        & powercfg.exe -Change -disk-timeout-ac 20
        & powercfg.exe -Change -disk-timeout-dc 20
        # Go to sleep after 4 hours (240 minutes)
        & powercfg.exe -Change -standby-timeout-ac 240
        & powercfg.exe -Change -standby-timeout-dc 240
    }
}

Write-Host "Power settings configured"
Write-Host ""
