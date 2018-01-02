#!/usr/bin/env powershell.exe

Import-Module -DisableNameChecking "$PSScriptRoot\..\Utilities\FileAndRegistryUtilities.psm1"

$winkey = "HKCU:\Software\Microsoft\Windows\CurrentVersion"

# Turn on Dark mode for apps
Set-RegistryInt "$winkey\Themes\Personalize" "AppsUseLightTheme" 0

# Automatically set accent color from backgrouns
Set-RegistryInt "HKCU:\Control Panel\Desktop" "AutoColorization" 1

# Use accent color in start, taskbar, and action center
Set-RegistryInt "$winkey\Themes\Personalize" "ColorPrevalance" 1

# Use accent color in title bars
Set-RegistryInt "HKCU:\Software\Microsoft\Windows\DWM" "ColorPrevalance" 1

# Use transparency
Set-RegistryInt "$winkey\Themes\Personalize" "EnableTransparancy" 1

# Show the Windows version on the desktop
# Disabled for now
#Set-RegistryInt "HKCU:\Control Panel\Desktop" "PaintDesktopVersion" 1




######
#TODO: Other settings I might want to incorporate
#
# For non-VM's, turn on NightLight and set it's schedule of times
#
#
