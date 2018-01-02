#!/usr/bin/env powershell.exe

Import-Module -DisableNameChecking "$PSScriptRoot\..\Utilities\FileAndRegistryUtilities.psm1"

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
