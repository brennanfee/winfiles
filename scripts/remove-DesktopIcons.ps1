#!/usr/bin/env pwsh
#Requires -Version 5
Set-StrictMode -Version 2.0

Write-Host "Removing desktop icons" -ForegroundColor "Green"

######## Remove Desktop Icons
$desktop = Get-SpecialFolder "Desktop"
Remove-Item "$desktop\*.lnk" -ErrorAction SilentlyContinue
Remove-Item "$env:PUBLIC\Desktop\*.lnk" -ErrorAction SilentlyContinue

Write-Host "Desktop icons removed"
Write-Host ""
