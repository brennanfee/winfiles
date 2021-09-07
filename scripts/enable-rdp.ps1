#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Enabling RDP" -ForegroundColor "Green"

# Enable rdp
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name fDenyTSConnections -Type DWord -Value 0

# Remove NLA
# NLA (Network Level Authentication)
$NLA = Get-WmiObject -Class Win32_TSGeneralSetting -ComputerName "." -Namespace root\CIMV2\TerminalServices -Authentication PacketPrivacy
#0 disable
#1 enable
$NLA.SetUserAuthenticationRequired(0)
# Recreate the WMI object so we can read out the (hopefully changed) setting
$NLA = Get-WmiObject -Class Win32_TSGeneralSetting -ComputerName "." -Namespace root\CIMV2\TerminalServices -Authentication PacketPrivacy
if ($NLA.UserAuthenticationRequired -eq 0) {
    Write-Host "NLA setting changed sucessfully"
}
else {
    Write-Host "Failed to change NLA setting" -ForegroundColor Red
    exit
}

# Allow RDP on firewall
Enable-NetFirewallRule -DisplayName 'Remote Desktop - User Mode (TCP-in)'

Write-Host "RDP Enabled"
Write-Host ""
