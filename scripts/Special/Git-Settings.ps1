#!/usr/bin/env powershell.exe

Import-Module -DisableNameChecking "$PSScriptRoot\..\Utilities\FileAndRegistryUtilities.psm1"

Param(
    [Parameter(Position=0)]
    [ValidateSet('home','work')]
    [string] $InstallType = "home"
)

# Git

Make-Link "$env:userprofile\.gitconfig" "$env:userprofile\winFiles\dotfiles\rcs\gitconfig"

Make-Link "$env:userprofile\.config\git\gitconfig.os" "$env:userprofile\winFiles\settings\gitconfig.os"

Make-Link "$env:userprofile\.config\git\gitconfig.user" "$env:userprofile\winFiles\dotfiles\rcs\tag-$InstallType\config\git\gitconfig.user"
