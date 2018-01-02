#!/usr/bin/env powershell.exe

Import-Module -DisableNameChecking "$PSScriptRoot\..\Utilities\FileAndRegistryUtilities.psm1"

# VsVim & ViEmu
Make-Link "$env:userprofile\_vsvimrc" "$env:userprofile\winFiles\settings\vsvimrc"
Make-Link "$env:userprofile\_viemurc" "$env:userprofile\winFiles\settings\viemurc"

# GVim
Make-Link "$env:userprofile\_vimrc" "$env:userprofile\winFiles\dotfiles\rcs\vimrc"
Make-Link "$env:userprofile\.vimrc.bundles" "$env:userprofile\winFiles\dotfiles\rcs\vimrc.bundles"
Make-Link "$env:userprofile\.vimrc.lightline" "$env:userprofile\winFiles\dotfiles\rcs\vimrc.lightline"
