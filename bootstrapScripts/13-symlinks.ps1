#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

$winFiles = "$env:ProfilePath\winfiles"

########  Git Configuration
Write-Host "Linking Git Configuration"

Remove-Item -Path "$env:USERPROFILE\.gitconfig"
New-SymbolicLink "$env:USERPROFILE\.config\git\config" "$winFiles\dotfiles\rcs\gitconfig"
New-SymbolicLink "$env:USERPROFILE\.config\git\gitconfig.os" "$winFiles\settings\gitconfig.os"

$tag = $global:InstallType
if ($global:InstallType == "gaming") {
    $tag = "home"
}

$target = "$winFiles\dotfiles\rcs\tag-$tag\config\git\gitconfig.user"
New-SymbolicLink "$env:USERPROFILE\.config\git\gitconfig.user" $target

######## Ignore file
# Used by RipGrep/Ag and other tools that respect ignore files

New-SymbolicLink "$env:USERPROFILE\.ignore" "$winFiles\dotfiles\rcs\ignore"
