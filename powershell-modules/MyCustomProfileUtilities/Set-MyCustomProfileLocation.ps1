#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Set-MyCustomProfileLocation {
    $DriveCount = (Get-PhysicalDisk | Measure-Object).Count

    $profilesPath="C:\profile"
    if ($DriveCount -ge 2) {
        $profilesPath="D:\profile"
    }

    Set-ProfileLocation $profilesPath
}

function Set-HomeEnvironmentVariable {
    # Add the HOME environment variables if not already set
    if ([string]::IsNullOrEmpty($env:HOME)) {
        $provider = get-psprovider FileSystem
        $provider.Home = $env:userprofile
        [environment]::SetEnvironmentVariable('HOME', "$env:userprofile", 'User')
        $env:HOME = $env:userprofile
    }
}
