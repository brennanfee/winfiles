#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Enable-RemoteDesktop {
    param(
        [switch]$DoNotRequireUserLevelAuthentication
    )

    Write-Host "Enabling Remote Desktop..."
    $obj = Get-WmiObject -Class "Win32_TerminalServiceSetting" -Namespace root\cimv2\terminalservices
    if($obj -eq $null) {
        Write-Host "Unable to locate terminalservices namespace. Remote Desktop is not enabled"
        return
    }
    try {
        $obj.SetAllowTsConnections(1,1) | Out-Null
    }
    catch {
        throw "There was a problem enabling remote desktop. Make sure your operating system supports remote desktop and there is no group policy preventing you from enabling it."
    }

    $obj2 = Get-WmiObject -class Win32_TSGeneralSetting -Namespace root\cimv2\terminalservices -ComputerName . -Filter "TerminalName='RDP-tcp'"

    if($obj2.UserAuthenticationRequired -eq $null) {
        Write-Host "Unable to locate Remote Desktop NLA namespace. Remote Desktop NLA is not enabled"
        return
    }
    try {
        if($DoNotRequireUserLevelAuthentication) {
            $obj2.SetUserAuthenticationRequired(0) | Out-Null
            Write-Host "Disabling Remote Desktop NLA ..."
        }
        else {
			$obj2.SetUserAuthenticationRequired(1) | Out-Null
            Write-Host "Enabling Remote Desktop NLA ..."
        }
    }
    catch {
        throw "There was a problem enabling Remote Desktop NLA. Make sure your operating system supports Remote Desktop NLA and there is no group policy preventing you from enabling it."
    }
}
