#!/usr/bin/env powershell.exe

Import-Module -DisableNameChecking "$PSScriptRoot\..\Utilities\FileAndRegistryUtilities.psm1"
Import-Module -DisableNameChecking "$PSScriptRoot\..\Utilities\Get-ComputerDetails.psm1"
$computerDetails = Get-ComputerDetails

if (!($computerDetails.IsVirtual))
{
    $key = "HKCU:\Control Panel\Desktop"
    # ScreenSaver settings
    Set-RegistryInt $key "ScreenSaveActive" 1
    Set-RegistryInt $key "ScreenSaverIsSecure" 1
    # 1800 = 30 minutes
    Set-RegistryInt $key "ScreenSaveTimeout" 1800
    Set-RegistryString $key "SCRNSAVE.EXE" "$env:SystemRoot\system32\scrnsave.scr"
}
