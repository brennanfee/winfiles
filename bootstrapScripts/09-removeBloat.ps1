#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Removing Microsoft bloat" -ForegroundColor "Green"

######  Remove OneDrive
## For the time being this is commented out

# This script will remove and disable OneDrive integration.

# Import-Module -DisableNameChecking $PSScriptRoot\..\Utilities\FileAndRegistryUtilities.psm1

# Write-Host "Kill OneDrive process"
# taskkill.exe /F /IM "OneDrive.exe"
# taskkill.exe /F /IM "explorer.exe"

# Write-Host "Remove OneDrive"
# if (Test-Path "$env:systemroot\System32\OneDriveSetup.exe") {
#     & "$env:systemroot\System32\OneDriveSetup.exe" /uninstall
# }
# if (Test-Path "$env:systemroot\SysWOW64\OneDriveSetup.exe") {
#     & "$env:systemroot\SysWOW64\OneDriveSetup.exe" /uninstall
# }

# Write-Host "Removing OneDrive leftovers"
# Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:localappdata\Microsoft\OneDrive"
# Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:programdata\Microsoft OneDrive"
# Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:systemdrive\OneDriveTemp"
# # check if directory is empty before removing:
# If ((Get-ChildItem "$env:userprofile\OneDrive" -Recurse | Measure-Object).Count -eq 0) {
#     Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:userprofile\OneDrive"
# }

# Write-Host "Disable OneDrive via Group Policies"
# $key = "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive"
# Set-RegistryInt $key "DisableFileSyncNGSC" 1

# Write-Host "Remove Onedrive from explorer sidebar"
# # Can't easily and reliably access HKCR with PowerShell
# cmd /c reg.exe ADD "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f
# cmd /c reg.exe ADD "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f

# Write-Host "Removing run hook for new users"
# cmd /c reg.exe load "hku\Default" "C:\Users\Default\NTUSER.DAT"
# cmd /c reg.exe delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f
# cmd /c reg.exe unload "hku\Default"

# Write-Output "Removing startmenu entry"
# Remove-Item -Force -ErrorAction SilentlyContinue "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"

# Write-Output "Removing scheduled task"
# Get-ScheduledTask -TaskPath '\' -TaskName 'OneDrive*' -ErrorAction SilentlyContinue | Unregister-ScheduledTask -Confirm:$false

# Write-Output "Restarting explorer"
# Start-Process "explorer.exe"

# Write-Output "Waiting for explorer to complete loading"
# Start-Sleep 10

# Write-Output "Removing additional OneDrive leftovers"
# foreach ($item in (Get-ChildItem "$env:WinDir\WinSxS\*onedrive*")) {
#     Set-FolderOwnership $item.FullName
#     Remove-Item -Recurse -Force $item.FullName -ErrorAction SilentlyContinue
# }

######## Remove some of the default Store Apps

# Removes some of the apps that come by default but are generally not needed.

$apps = @(
    "Microsoft.3DBuilder"
    "Microsoft.BingNews"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.Messaging"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.MicrosoftStickyNotes"
    "Microsoft.MixedReality.Portal"
    "Microsoft.MSPaint"
    "Microsoft.Office.OneNote"
    "Microsoft.Office.Sway"
    "Microsoft.OneConnect"
    "Microsoft.People"
    "Microsoft.ScreenSketch"
    "Microsoft.SkypeApp"
    "Microsoft.Wallet"
    "Microsoft.Windows.Photos"
    "microsoft.windowscommunicationsapps"
    "Microsoft.WindowsMaps"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "Windows.CBSPreview"
    # non-Microsoft
    "king.com.BubbleWitch3Saga"
    "king.com.CandyCrushFriends"
    "king.com.CandyCrushSaga"
    "king.com.FarmHeroesSaga"
    "king.com.*"
    "NORDCURRENT.COOKINGFEVER"
    "SpotifyAB.SpotifyMusic"
)

foreach ($app in $apps) {
    Write-Host "Trying to remove $app"

    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage

    $null = Get-AppxProvisionedPackage -Online |
    Where-Object DisplayName -eq $app |
    Remove-AppxProvisionedPackage -Online

    Start-Sleep 5
}

Write-Host "Microsoft bloat removed"
Write-Host ""
