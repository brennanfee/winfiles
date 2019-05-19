#!/usr/bin/env powershell.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

# Copy paste.exe to C:\Windows\system32 directory
Copy-Item -Path "$env:ProfilePath\winfiles\installs\paste.exe" -Destination "$env:SystemRoot\system32"

# Setup "extras" repo for scoop
Invoke-Expression "scoop bucket add extras"

# Install AppGet
#Invoke-Expression "$env:ProfilePath\winfiles\installs\appget.exe"
