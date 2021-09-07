#!/usr/bin/env pwsh.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Enable-RemoteDesktop {
    param(
        [switch]$DoNotRequireUserLevelAuthentication
    )

    Write-Host "Enabling Remote Desktop..."
    $obj = Get-WmiObject -Class "Win32_TerminalServiceSetting" -Namespace root\cimv2\terminalservices
    if ($null -eq $obj) {
        Write-Host "Unable to locate terminalservices namespace. Remote Desktop is not enabled"
        return
    }
    try {
        $null = $obj.SetAllowTsConnections(1, 1)
    }
    catch {
        throw "There was a problem enabling remote desktop. Make sure your operating system supports remote desktop and there is no group policy preventing you from enabling it."
    }

    $obj2 = Get-WmiObject -class Win32_TSGeneralSetting -Namespace root\cimv2\terminalservices -ComputerName . -Filter "TerminalName='RDP-tcp'"

    if ($null -eq $obj2.UserAuthenticationRequired) {
        Write-Host "Unable to locate Remote Desktop NLA namespace. Remote Desktop NLA is not enabled"
        return
    }
    try {
        if ($DoNotRequireUserLevelAuthentication) {
            $null = $obj2.SetUserAuthenticationRequired(0)
            Write-Host "Disabling Remote Desktop NLA ..."
        }
        else {
            $null = $obj2.SetUserAuthenticationRequired(1)
            Write-Host "Enabling Remote Desktop NLA ..."
        }
    }
    catch {
        throw "There was a problem enabling Remote Desktop NLA. Make sure your operating system supports Remote Desktop NLA and there is no group policy preventing you from enabling it."
    }
}
