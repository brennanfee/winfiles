#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

######## Remove Desktop Icons
$desktop = Get-SpecialFolder "Desktop"
Remove-Item "$desktop\*.lnk" -ErrorAction SilentlyContinue
Remove-Item "$env:PUBLIC\Desktop\*.lnk" -ErrorAction SilentlyContinue
