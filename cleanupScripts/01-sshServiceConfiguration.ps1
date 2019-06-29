#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Checking sshd service"
if (Get-Service -Name sshd -ErrorAction SilentlyContinue) {
    Start-Service -Name sshd -ErrorAction SilentlyContinue
    Set-Service -Name sshd -StartupType 'Automatic' -ErrorAction SilentlyContinue | Out-Null
}

Write-Host "Checking ssh-agent service"
if (Get-Service -Name ssh-agent -ErrorAction SilentlyContinue) {
    Start-Service -Name ssh-agent - ErrorAction SilentlyContinue
    Set-Service -Name ssh-agent -StartupType 'Automatic' -ErrorAction SilentlyContinue | Out-Null
}
