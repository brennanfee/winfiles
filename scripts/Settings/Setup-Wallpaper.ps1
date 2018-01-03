#!/usr/bin/env powershell.exe

Import-Module -DisableNameChecking "$PSScriptRoot\..\Utilities\FileAndRegistryUtilities.psm1"

# Automatically set accent color from backgrouns
Set-RegistryInt "HKCU:\Control Panel\Desktop" "Wallpaper" "$PSScriptRoot\..\..\dotfiles\wallpapers\1920x1080\darkest-hour.jpg"
