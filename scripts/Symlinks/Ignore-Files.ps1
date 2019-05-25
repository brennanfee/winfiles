#!/usr/bin/env pwsh.exe

Import-Module -DisableNameChecking "$PSScriptRoot\..\Utilities\FileAndRegistryUtilities.psm1"

# RipGrep/Ag
Make-Link "$env:userprofile\.ignore" "$env:userprofile\winFiles\dotfiles\rcs\ignore"
