#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Configuring PowerShell Execution Policies" -ForegroundColor "Green"
Write-Host ""

function Is64Bit { [IntPtr]::Size -eq 8 }

function OnWindows { $PSEdition -eq "Desktop" -or $PSVersionTable.Platform -eq "Win32NT" }

if (OnWindows) {
    $executionPolicyBlock = {
        Set-ExecutionPolicy RemoteSigned -Scope Process -Force -ErrorAction Ignore
        Set-ExecutionPolicy RemoteSigned -Scope LocalMachine -Force -ErrorAction Ignore
        Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force -ErrorAction Ignore
    }

    $arguments = "-NoProfile -NonInteractive -ExecutionPolicy Unrestricted " +
    "-Command $executionPolicyBlock"

    # Standard powershell
    Write-Host "Configuring standard PowerShell"
    Start-Process -Wait -NoNewWindow -FilePath "powershell.exe" -ArgumentList $arguments

    # If on 64-bit install, need to run an extra command for 32-bit powershell
    if (Is64Bit) {
        Write-Host "Configuring 32-bit PowerShell"
        Start-Process -Wait -NoNewWindow -ArgumentList $arguments `
            -FilePath "$env:SystemRoot\SysWOW64\WindowsPowerShell\v1.0\powershell.exe"
    }

    # If PowerShell Core is installed, it also needs configuration
    $powerShellCore = (Get-Command pwsh.exe -ErrorAction SilentlyContinue)

    if ($powerShellCore) {
        Write-Host "Configuring PowerShell Core"
        Start-Process -Wait -NoNewWindow -FilePath $powerShellCore.Source -ArgumentList $arguments
    }
}

Write-Host ""
Write-Host "PowerShell Execution Policies configured" -ForegroundColor "Green"
Write-Host ""
