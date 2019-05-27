#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

if (Get-Service -Name sshd) {
    Start-Service -Name sshd
    Set-Service -Name sshd -StartupType 'Automatic' | Out-Null
}

if (Get-Service -Name ssh-agent) {
    Start-Service -Name ssh-agent
    Set-Service -Name ssh-agent -StartupType 'Automatic'  | Out-Null
}

#Install-Module -Force OpenSSHUtils -Scope AllUsers
