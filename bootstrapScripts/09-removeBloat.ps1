#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Removing Microsoft bloat" -ForegroundColor "Green"

######  Remove OneDrive And Clean Up
## TODO: Add a thing to my profile to get the winget.exe with full path
$wingetExe = "winget.exe"

& "$wingetExe" uninstall --silent --accept-source-agreements Microsoft.OneDrive

Write-Host "Removing OneDrive leftovers"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:localappdata\Microsoft\OneDrive"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:programdata\Microsoft OneDrive"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:systemdrive\OneDriveTemp"
# check if directory is empty before removing:
If ((Get-ChildItem "$env:userprofile\OneDrive" -Recurse | Measure-Object).Count -eq 0) {
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:userprofile\OneDrive"
}

######## Remove some of the default Store Apps

# Removes some of the apps that come by default but are generally not needed.

$apps = @(
    "Microsoft.3DBuilder"
    "Microsoft.Advertising.Xaml"
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

    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue

    $null = Get-AppxProvisionedPackage -Online |
    Where-Object DisplayName -eq $app |
    Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue

    Start-Sleep 5
}

Write-Host "Microsoft bloat removed"
Write-Host ""
