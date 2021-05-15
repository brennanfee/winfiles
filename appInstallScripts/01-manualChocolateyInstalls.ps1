#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

# Manual applications - These are apps that are on all machines and that have special installation parameters.

Write-Host "Installing applications using Chocolatey - Manual"

## Firefox first
Write-Host "Installing firefox"
Install-WithChocolatey "firefox"

## Git
Write-Host "Installing git"
Install-WithChocolatey "git" "/GitOnlyOnPath /NoAutoCrlf /WindowsTerminal /NoShellIntegration"

## Powershell Core
Write-Host "Installing powershell-core"
Install-WithChocolatey "powershell-core" "" "/quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1"

## Vim-tux
## NOTE: I still need to compare vim and vim-tux to determine which features are different between builds and whether or not I care.
Write-Host "Installing vim-tux"
Install-WithChocolatey "vim-tux" "/InstallPopUp /RestartExplorer /NoDefaultVimrc /NoDesktopShortcuts"

# Only install Virtualbox on machines that are not themselves virtual
$computerDetails = Get-ComputerDetails

if (-not ($computerDetails.IsVirtual)) {
    Write-Host "Installing Virtualbox"
    Install-WithChocolatey "virtualbox" "/NoDesktopShortcut /ExtensionPack"
}
