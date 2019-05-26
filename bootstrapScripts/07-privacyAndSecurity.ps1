#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

# Turn off Telemetry (set to Basic)
$key = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
Set-RegistryInt $key "AllowTelemetry" 1

# Turn off "Occasionally Show Suggestions In Start"
$cdm = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
Set-RegistryInt $cdm "SubscribedContent-338388Enabled" 0

# Turn off "Get Tips, Tricks, and Suggestions as you use Windows"
Set-RegistryInt $cdm "SubscribedContent-338389Enabled" 0

# Turn off "Show me Windows welcome experience after updates and occasionally when I sign in..."
Set-RegistryInt $cdm "SubscribedContent-310093Enabled" 0

# Increase the notification display time, 7 seconds
Set-RegistryInt "HKCU:\Control Panel\Accessibility" "MessageDuration" 7

# Turn off the use of Advertising ID
$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
Set-RegistryInt $key "Enabled" 0

# Do NOT allow apps to send emails
$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\" +
"{9231CB4C-BF57-4AF3-8C55-FDA7BFCC04C5}"
Set-RegistryString $key "Value" "Deny"

# Turn off tailoring experience using diagnostics data
$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy"
Set-RegistryInt $key "TailoredExperiencesWithDiagnosticDataEnabled" 0

# Turn off "Show recommended app suggestions" for Ink Workspace
$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\PenWorkspace"
Set-RegistryInt $key "PenWorkspaceAppSuggestionsEnabled" 0
