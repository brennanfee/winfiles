#!/usr/bin/env powershell.exe
#Requires -Version 4
#Requires -RunAsAdministrator

# Turn all network connections to "Private"
Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private
