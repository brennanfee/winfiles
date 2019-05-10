#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Set-MyCustomProfileLocation {
    [CmdletBinding()]

    $DriveCount = (Get-PhysicalDisk | Measure-Object).Count

    $profilesPath="C:\profile"
    if ($DriveCount -ge 2) {
        $profilesPath="D:\profile"
    }

    Set-ProfileLocation $profilesPath
}
