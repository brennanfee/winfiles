#!/usr/bin/env powershell.exe

Import-Module -DisableNameChecking "$PSScriptRoot\..\Utilities\FileAndRegistryUtilities.psm1"

# RipGrep/Ag
Make-Link "$env:userprofile\.agignore" "$env:userprofile\winFiles\dotfiles\rcs\agignore"

Make-Link "$env:userprofile\.ignore" "$env:userprofile\winFiles\dotfiles\rcs\ignore"
