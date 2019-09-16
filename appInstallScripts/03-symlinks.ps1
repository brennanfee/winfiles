#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

$winFiles = "$env:PROFILEPATH\winfiles"

########  Git Configuration
Write-Host "Linking Git Configuration"

Remove-Item -Path "$env:USERPROFILE\.gitconfig" -ErrorAction SilentlyContinue
New-SymbolicLink "$env:USERPROFILE\.config\git\config" "$winFiles\dotfiles\rcs\config\git\config"
New-SymbolicLink "$env:USERPROFILE\.config\git\gitconfig.os" "$winFiles\settings\gitconfig.os"

$tag = "home"
if ($env:SYSTEMTYPE -eq "WORK") {
    $tag = "work"
}

$target = "$winFiles\dotfiles\rcs\tag-$tag\config\git\gitconfig.user"
New-SymbolicLink "$env:USERPROFILE\.config\git\gitconfig.user" $target

######## Ignore file
Write-Host "Linking Ignore file"
# Used by RipGrep/Ag and other tools that respect ignore files

New-SymbolicLink "$env:USERPROFILE\.ignore" "$winFiles\dotfiles\rcs\ignore"

######## Windows Terminal
Write-Host "Linking Windows Terminal Settings"
Invoke-Expression "$PSScriptRoot\..\shared\symlink-terminal-settings.ps1"

######## Vim
Write-Host "Linking Vim settings"

# Create the directories
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.cache\vim" | Out-Null
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.vim\vimscratch\backup" | Out-Null
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.vim\vimscratch\swap" | Out-Null
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.vim\vimscratch\undo" | Out-Null

# VsVim & ViEmu
New-SymbolicLink "$env:USERPROFILE\_vsvimrc" "$winFiles\settings\vsvimrc"
New-SymbolicLink "$env:USERPROFILE\_viemurc" "$winFiles\settings\viemurc"

# GVim
New-SymbolicLink "$env:USERPROFILE\_vimrc" "$winFiles\dotfiles\rcs\vim\vimrc" -Force
New-SymbolicLink "$env:USERPROFILE\.vim\vimrc.bundles" "$winFiles\dotfiles\rcs\vim\vimrc.bundles"
New-SymbolicLink "$env:USERPROFILE\.vim\vimrc.lightline" "$winFiles\dotfiles\rcs\vim\vimrc.lightline"

# Download minpac if not present
$minpacPath = "$env:USERPROFILE\.vim\pack\minpac\opt\minpac"
if (-not (Test-Path $minpacPath)) {
    git clone "https://github.com/k-takata/minpac.git" $minpacPath
}

# Initialize the bundles
if (Get-Command "gvim.exe") {
    gvim.exe -N -u "$env:USERPROFILE\.vim\vimrc.bundles" +PackUpdate +PackClean +qa -
}
