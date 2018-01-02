#!/usr/bin/env powershell.exe

Param(
    [Parameter(Position=0)]
    [ValidateSet('home','work')]
    [string] $InstallType = "home"
)

# Git

If(!(Test-Path "$env:userprofile\.gitconfig"))
{
    cmd /c mklink "$env:userprofile\.gitconfig" "$env:userprofile\winFiles\dotfiles\rcs\gitconfig"
}

If(!(Test-Path "$env:userprofile\.gitconfig.os"))
{
    cmd /c mklink "$env:userprofile\.gitconfig.os" "$env:userprofile\winFiles\settings\gitconfig.os"
}

If(!(Test-Path "$env:userprofile\.gitconfig.user"))
{
    cmd /c mklink "$env:userprofile\.gitconfig.user" "$env:userprofile\winFiles\dotfiles\rcs\tag-$InstallType\gitconfig.user"
}
