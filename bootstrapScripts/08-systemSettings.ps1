#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

$computerDetails = Get-ComputerDetails

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

# Set wallpaper
$wallpaper = "$env:ProfilePath\winfiles\dotfiles\wallpapers\1920x1080\darkest-hour.jpg"
Set-RegistryInt "HKCU:\Control Panel\Desktop" "Wallpaper" $wallpaper

# Show the Windows version on the desktop
# Disabled for now
#Set-RegistryInt "HKCU:\Control Panel\Desktop" "PaintDesktopVersion" 1

# Night Light Settings
$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\" +
"DefaultAccount\Current\default$windows.data.bluelightreduction.settings\" +
"windows.data.bluelightreduction.settings"
$value = ([byte[]](0x43, 0x42, 0x01, 0x00, 0x0A, 0x02, 0x01, 0x00,
    0x2A, 0x06, 0xB1, 0x9E, 0xA8, 0xE7, 0x05, 0x2A))
Set-RegistryValue $key "Data" $value
$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\" +
"DefaultAccount\Current\default$windows.data.bluelightreduction." +
"bluelightreductionstate\windows.data.bluelightreduction.bluelightreductionstate"
Set-RegistryValue $key "Data" $value

# Screen Save Settings
if (-not ($computerDetails.IsVirtual)) {
    $key = "HKCU:\Control Panel\Desktop"
    # ScreenSaver settings
    Set-RegistryInt $key "ScreenSaveActive" 1
    Set-RegistryInt $key "ScreenSaverIsSecure" 1
    # 1800 = 30 minutes
    Set-RegistryInt $key "ScreenSaveTimeout" 1800
    Set-RegistryString $key "SCRNSAVE.EXE" "$env:SystemRoot\system32\scrnsave.scr"
}
