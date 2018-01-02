#!/usr/bin/env powershell.exe

Import-Module -DisableNameChecking "$PSScriptRoot\..\Utilities\FileAndRegistryUtilities.psm1"

# Trun off web searches
Set-WindowsSearchSetting -EnableWebResultsSetting $False

# Turn off Cortana when device is locked
Set-RegistryInt "HKCU:\Software\Speech_OneCore\Preferences" "VoiceActivationEnableAboveLockscreen" 0

# Turn off Voice Activation
Set-RegistryInt "HKCU:\Software\Speech_OneCore\Preferences" "VoiceActivationOn" 0

# Turn off the Cortana Shortcut (win+c)
Set-RegistryInt "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" "VoiceShortcut" 0

# Turn on storage sense (I know, not a search setting)
Set-RegistryInt "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" "StoragePoliciesNotified" 1
