#!/usr/bin/env pwsh.exe

Import-Module -DisableNameChecking "$PSScriptRoot\..\Utilities\FileAndRegistryUtilities.psm1"

$explorerKey = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer'

# Switch app on click of taskbar icon (default behavior is to view mini-windows)
Set-RegistryInt "$explorerKey\Advanced" "LastActiveClick" 1

# Show the larger icons in the taskbar
Set-RegistryInt "$explorerKey\Advanced" "TaskbarSmallIcons" 0

# Lock the taskbar from being moved
Set-RegistryInt "$explorerKey\Advanced" "TaskbarSizeMove" 0

# Always combine (and hide the text) for taskbar buttons
Set-RegistryInt "$explorerKey\Advanced" "TaskbarGlomLevel" 0

# Turn off "People" button in the Taskbar
Set-RegistryInt "$explorerKey\Advanced\People" "PeopleBand" 0
