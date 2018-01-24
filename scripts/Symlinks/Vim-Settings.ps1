#!/usr/bin/env powershell.exe

Import-Module -DisableNameChecking "$PSScriptRoot\..\Utilities\FileAndRegistryUtilities.psm1"

# Create the cache directory
mkdir "$env:userprofile\.cache\vim"
mkdir "$env:userprofile\.vim"

# VsVim & ViEmu
Make-Link "$env:userprofile\_vsvimrc" "$env:userprofile\winFiles\settings\vsvimrc"
Make-Link "$env:userprofile\_viemurc" "$env:userprofile\winFiles\settings\viemurc"

# GVim
Make-Link "$env:userprofile\_vimrc" "$env:userprofile\winFiles\dotfiles\rcs\vimrc"
Make-Link "$env:userprofile\.vim\vimrc.bundles" "$env:userprofile\winFiles\dotfiles\rcs\vim\vimrc.bundles"
Make-Link "$env:userprofile\.vim\vimrc.lightline" "$env:userprofile\winFiles\dotfiles\rcs\vim\vimrc.lightline"

