#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Setting up system and personalization settings" -ForegroundColor "Green"

$computerDetails = Get-ComputerDetails

########  Page file settings
$pagefile = Get-WmiObject Win32_ComputerSystem -EnableAllPrivileges
$pagefile.AutomaticManagedPagefile = $true
$pagefile.put() | Out-Null

########  Theme Settings
Write-Host "Theme settings"

$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion"

# Turn on Dark mode for apps
Set-RegistryInt "$key\Themes\Personalize" "AppsUseLightTheme" 0
Set-RegistryString "$key\Themes\Personalize" "Append Completion" "yes"

# Automatically set accent color from backgrouns
Set-RegistryInt "HKCU:\Control Panel\Desktop" "AutoColorization" 1

# Faster menu display
Set-RegistryString "HKCU:\Control Panel\Desktop" "MenuShowDelay" "50"

# Use accent color in start, taskbar, and action center
Set-RegistryInt "$key\Themes\Personalize" "ColorPrevalance" 1

# Use accent color in title bars
Set-RegistryInt "HKCU:\Software\Microsoft\Windows\DWM" "ColorPrevalance" 1

# Use transparency
Set-RegistryInt "$key\Themes\Personalize" "EnableTransparancy" 1

# Set wallpaper
$wallpaper = "$env:PROFILEPATH\winfiles\dotfiles\wallpapers\1920x1080\darkest-hour.jpg"
$key = "HKCU:\Control Panel\Desktop"
Set-RegistryString $key "Wallpaper" $wallpaper

# Raise the wallpaper quality
Set-RegistryInt $key "JPEGImportQuality" 100

# Show the Windows version on the desktop
# Disabled for now
#Set-RegistryInt "HKCU:\Control Panel\Desktop" "PaintDesktopVersion" 1

########  Night Light Settings
# Write-Host "Night Light Settings"

# $key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\" +
# 'DefaultAccount\Current\default$windows.data.bluelightreduction.settings\' +
# "windows.data.bluelightreduction.settings"
# $hexified = "43,42,01,00,0A,02,01,00,2A,06,B1,9E,A8,E7,05,2A".
# Split(',') | ForEach-Object { "0x$_" };

# Set-RegistryValue $key "Data" ([byte[]]$hexified) "Binary"

# $key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\" +
# 'DefaultAccount\Current\default$windows.data.bluelightreduction.' +
# "bluelightreductionstate\windows.data.bluelightreduction.bluelightreductionstate"
# Set-RegistryValue $key "Data" ([byte[]]$hexified) "Binary"

########  Screen Saver
Write-Host "Screen Save Settings"

if (-not ($computerDetails.IsVirtual)) {
    $key = "HKCU:\Control Panel\Desktop"
    # ScreenSaver settings
    Set-RegistryInt $key "ScreenSaveActive" 1
    Set-RegistryInt $key "ScreenSaverIsSecure" 1
    # 1800 = 30 minutes
    Set-RegistryInt $key "ScreenSaveTimeout" 1800
    Set-RegistryString $key "SCRNSAVE.EXE" "$env:SystemRoot\system32\scrnsave.scr"
}
else {
    Set-RegistryInt "HKCU:\Control Panel\Desktop" "ScreenSaveActive" 0
}

########  Explorer Settings
Write-Host "Explorer Settings"

$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer'

# Show file extensions
Set-RegistryInt "$key\Advanced" "HideFileExt" 0

# Show hidden files, folders, and drives
Set-RegistryInt "$key\Advanced" "Hidden" 1

# Disable showing protected OS files
Set-RegistryInt "$key\Advanced" "ShowSuperHidden" 0

# Show the full path in the title bar of explorer
Set-RegistryInt "$key\CabinetState" "FullPath" 1

# Turn off recent files in Quick Access
Set-RegistryInt "$key" "ShowRecent" 0

# Turn off frequent directories in Quick Access
Set-RegistryInt "$key" "ShowFrequent" 0

# Disable expanding to open folder (in the tree of paths, disables it tracking the main pain)
Set-RegistryInt "$key\Advanced" "NavPaneExpandToCurrentFolder" 0

# Launch explorer to "My PC", not Quick Access
Set-RegistryInt "$key\Advanced" "LaunchTo" 1

# Hide Ribbon in Explorer
Set-RegistryInt "$key\Ribbon" "MinimizedStateTabletModeOff" 1

# Run explorer sessions in separate processes
Set-RegistryInt "$key\Advanced" "SeparateProcess" 1

# Always show menus in explorer
Set-RegistryInt "$key\Advanced" "AlwaysShowMenus" 1

# Use "Peek" to preview desktop when hovered over bottom-right
Set-RegistryInt "$key\Advanced" "DisablePreviewDesktop" 0

# Turn off "Show sync provider notifications" (advertising)
Set-RegistryInt "$key\Advanced" "ShowSyncProviderNotifications" 0

# Turn off the Startup delay for Startup Apps
Set-RegistryInt "$key\Serialize" "StartupDelayInMSec" 0

# Enable Autocomplete in Explorer
Set-RegistryString "$key\AutoComplete" "Append Completion" "yes"

# Disable Autoplay
Set-RegistryInt "$key\AutoplayHandlers" "DisableAutoplay" 1

# Disable Thumbnail Cache
Set-RegistryInt "$key\Advanced" "DisableThumbnailCache" 1
Set-RegistryInt "$key\Advanced" "DisableThumbsDBOnNetworkFolders" 1

# Turn off the "You have new apps that can open this type of file" thing
$key = "HKLM:\Software\Policies\Microsoft\Windows\Explorer"
Set-RegistryInt "$key" "NoNewAppAlert" 1
# Turn of "Look For An App In The Store..."
Set-RegistryInt "$key" "NoUseStoreOpenWith" 1

# Disable Autorun for all drives
$key = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
Set-RegistryInt "$key" "NoDriveTypeAutoRun" 255

######## File system settings
Set-RegistryInt "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" "LongPathsEnabled" 1

######## Accessibility
# Disable Sticky Keys Prompt
$key = "HKCU:\Control Panel\Accessibility\StickyKeys"
Set-RegistryString $key "Flags" "506"

######## Control Panel
# Show "large" icons
$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel"
Set-RegistryInt "$key" "AllItemsIconView" 0

########  Notepad settings
Write-Host "Notepad Settings"
$key = "HKCU:\Software\Microsoft\Notepad"
Set-RegistryString "$key" "lfFaceName" "JetBrains Mono Medium"
Set-RegistryInt "$key" "iPointSize" 140
Set-RegistryInt "$key" "lfWeight" 500

########  Terminal (conhost) settings
Write-Host "Terminal Settings"

# I don't believe this is still needed with latest versions of Windows
#$key = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Console\TrueTypeFont'
#Set-RegistryString "$key" "000" "JetBrains Mono Medium"
#Set-RegistryString "$key" "0000" "JetBrains Mono"
#Set-RegistryString "$key" "00000" "JetBrainsMono Nerd Font Mono"
#Set-RegistryString "$key" "000000" "Hack"
#Set-RegistryString "$key" "0000000" "Hack Nerd Font Mono"

$key = 'HKCU:\Console'
# Setup font for console
#Set-RegistryString "$key" "FaceName" "__DefaultTTFont__"
Set-RegistryString "$key" "FaceName" "JetBrains Mono Medium"
Set-RegistryInt "$key" "FontSize" 1310720

# Console settings
Set-RegistryInt "$key" "ForceV2" 1
Set-RegistryInt "$key" "LineSelection" 1
Set-RegistryInt "$key" "FilterOnPaste" 1
Set-RegistryInt "$key" "LineWrap" 1
Set-RegistryInt "$key" "CtrlKeyShortcutsDisabled" 0
Set-RegistryInt "$key" "ExtendedEditKey" 0
Set-RegistryInt "$key" "TrimLeadingZeros" 0
Set-RegistryInt "$key" "WindowsAlpha" 243
Set-RegistryInt "$key" "InsertMode" 1
Set-RegistryInt "$key" "QuickEdit" 1
Set-RegistryInt "$key" "InterceptCopyPaste" 1
Set-RegistryInt "$key" "LineSelection" 1
Set-RegistryInt "$key" "TerminalScrolling" 0

# Block cursor, inverse color
Set-RegistryInt "$key" "CursorType" 4
Set-RegistryValue "$key" "CursorColor" 4294967295 "DWord"

Set-RegistryInt "$key" "HistoryBufferSize" 999
Set-RegistryInt "$key" "NumberOfHistoryBuffers" 4
Set-RegistryInt "$key" "HistoryNoDup" 1

# Powershell
$key = 'HKCU:\Console\%SystemRoot%_System32_WindowsPowerShell_v1.0_powershell.exe'
Set-RegistryString "$key" "FaceName" "JetBrains Mono Medium"
Set-RegistryInt "$key" "FontSize" 1310720
Set-RegistryInt "$key" "QuickEdit" 1

$key = 'HKCU:\Console\%SystemRoot%_SysWOW64_WindowsPowerShell_v1.0_powershell.exe'
Set-RegistryString "$key" "FaceName" "JetBrains Mono Medium"
Set-RegistryInt "$key" "FontSize" 1310720
Set-RegistryInt "$key" "QuickEdit" 1

########  Taskbar Settings
Write-Host "Taskbar Settings"

$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer'

# Remove "Task View" Button from Taskbar
# currently disabled, not sure about this one
#Set-RegistryInt "$key\Advanced" "ShowTaskViewButton" 0

# Switch app on click of taskbar icon (default behavior is to view mini-windows)
Set-RegistryInt "$key\Advanced" "LastActiveClick" 1

# Show the larger icons in the taskbar
Set-RegistryInt "$key\Advanced" "TaskbarSmallIcons" 0

# Lock the taskbar from being moved
Set-RegistryInt "$key\Advanced" "TaskbarSizeMove" 0

# Always combine (and hide the text) for taskbar buttons
Set-RegistryInt "$key\Advanced" "TaskbarGlomLevel" 0

# Turn off "People" button in the Taskbar
Set-RegistryInt "$key\Advanced\People" "PeopleBand" 0

# Turn off tracking recent programs and recent documents
Set-RegistryInt "$key\Advanced" "Start_TrackProgs" 0
Set-RegistryInt "$key\Advanced" "Start_TrackDocs" 0

# Disable Edge desktop shortcut
Set-RegistryInt "$key" "DisableEdgeDesktopShortcutCreation" 1

########  Search Settings
Write-Host "Search Settings"

# Trun off web searches
## This method doesn't seem to work any more.  It gives errors
## no matter whether I'm trying to set it to false or true.
## The error given is about your "organization" is managing
## that value, even on machines that are not managed by an
## organization.  Will return to examine further or
## eventually remove.
#Set-WindowsSearchSetting -EnableWebResultsSetting $False

#Set-WindowsSearchSetting -EnableWebResultsSetting $False -SafeSearchSetting "Off" -SearchExperienceSetting "NotPersonalized" -ErrorAction SilentlyContinue

# So use the registry instead
$key = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings"
Set-RegistryInt $key "IsAADCloudSearchEnabled" 0
Set-RegistryInt $key "IsMSACloudSearchEnabled" 0
Set-RegistryInt $key "SafeSearchMode" 0

# Turn off Cortana when device is locked
Set-RegistryInt "HKCU:\Software\Speech_OneCore\Preferences" "VoiceActivationEnableAboveLockscreen" 0

# Turn off Voice Activation
Set-RegistryInt "HKCU:\Software\Speech_OneCore\Preferences" "VoiceActivationOn" 0

# Turn off the Cortana Shortcut (win+c)
$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"
Set-RegistryInt $key "VoiceShortcut" 0

# Remove Search Box/Button from Taskbar, 0 = no search, 1 = search icon, 2 = search bar
Set-RegistryInt $key "SearchboxTaskbarMode" 1

# Turn on storage sense (I know, not a search setting)
Set-RegistryInt "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" "StoragePoliciesNotified" 1

# Disable Game Bar Tips
Set-RegistryInt "HKCU:\SOFTWARE\Microsoft\GameBar" "ShowStartupPanel" 0
Set-RegistryInt "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" "AllowGameDVR" 0
Set-RegistryInt "HKCU:\System\GameConfigStore" "GameDVR_Enabled" 0

$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"
Set-RegistryInt $key "CanCortanaBeEnabled" 0
Set-RegistryInt $key "DeviceHistoryEnabled" 0
Set-RegistryInt $key "CortanaEnabled" 0
Set-RegistryInt $key "CortanaInAmbientMode" 0
# Disable Bing search
# Temporarily remove this one, a recent Win 10 update is causing issues with search if this is disabled
#Set-RegistryInt $key "BingSearchEnabled" 0
Set-RegistryInt $key "HistoryViewEnabled" 0
# Turn off the Cortana Shortcut (win+c)
Set-RegistryInt $key "VoiceShortcut" 0

$key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
Set-RegistryInt $key "AllowSearchToUseLocation" 0
Set-RegistryInt $key "DisableWebSearch" 1
Set-RegistryInt $key "AllowCloudSearch" 0
Set-RegistryInt $key "AllowCortana" 0
Set-RegistryInt $key "AllowCortanaAboveLock" 0

#Add "Run as different user" to context menu
$key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
Set-RegistryInt $key "ShowRunasDifferentuserinStart" 1

########  Copy
# Show detailed copy dialog by default
$key = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager"
Set-RegistryInt $key "EnthusiastMode" 1

########  Keyboard Settings
Write-Host "Keyboard Settings"

# Map the CAPS LOCK key to the Control key
$hexified = "00,00,00,00,00,00,00,00,02,00,00,00,1d,00,3a,00,00,00,00,00".
Split(',') | ForEach-Object { "0x$_" };

$key = "HKLM:\System\CurrentControlSet\Control\Keyboard Layout"
Set-RegistryValue $key "Scancode Map" ([byte[]]$hexified) "Binary"

# Lower keyboard delay
Set-RegistryInt "HKCU:\Control Panel\Keyboard" "KeyboardDelay" 0

Write-Host "System and personalization settings configured"
Write-Host ""
