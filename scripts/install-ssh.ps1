#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Checking Microsoft OpenSSH features..." -ForegroundColor "Green"
# Install the features
$delay = 15

$features = Get-WindowsCapability -Online | Where-Object { $_.Name.StartsWith("OpenSSH") }
foreach ($feature in $features) {
    $name = $feature.Name
    Write-Host ""
    Write-Host "Checking feature: $name"

    if ($feature.State -eq "NotPresent") {
        Write-Host "Enabling feature: $name"
        $null = Add-WindowsCapability -Online -Name $name
        Start-Sleep $delay
        Write-Host "Feature enabled: $name"
    }
    else {
        Write-Host "Feature '$name' already enabled"
    }
}

Write-Host "Configuring SSH Service"

# Locate PowerShell with a priority on Core
$powerShellCmd = (Get-Command -Name pwsh.exe -ErrorAction SilentlyContinue)
$defaultPowerShellCorePath = "C:\Program Files\PowerShell\7\pwsh.exe"
if ($powerShellCmd) {
    $powerShell = "$($powerShellCmd.Source)"
}
elseif (Test-Path -Path $defaultPowerShellCorePath) {
    $powerShell = $defaultPowerShellCorePath
}
else {
    $powerShell = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
}

# Set the default shell to PowerShell Core
$null = New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value $powerShell -PropertyType String -Force

# Setup the firewall and the service
Write-Host "Checking sshd service"
Enable-NetFirewallRule -DisplayName 'OpenSSH SSH Server (sshd)'
Set-Service -Name sshd -StartupType 'Automatic'
# Need to start the service first to create the config files in C:\ProgramData\ssh
Start-Service -Name sshd

# Increase the MaxAuthTries in sshd_config
$file = "C:\ProgramData\ssh\sshd_config"
$find = "#MaxAuthTries 6"
$replace = "MaxAuthTries 20"
(Get-Content $file).replace($find, $replace) | Set-Content $file
Restart-Service -Name sshd

Write-Host "Checking ssh-agent service"
if (Get-Service -Name ssh-agent -ErrorAction SilentlyContinue) {
    Start-Service -Name ssh-agent -ErrorAction SilentlyContinue
    $null = Set-Service -Name ssh-agent -StartupType 'Automatic' -ErrorAction SilentlyContinue
}

Write-Host ""
Write-Host "Microsoft OpenSSH configured." -ForegroundColor "Cyan"
Write-Host ""
