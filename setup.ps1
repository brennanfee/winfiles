#!/usr/bin/env powershell

# Create links for settings files
#

Param(
    [Parameter(Position=0)]
    [ValidateSet('home','work')]
    [string] $installType = "home"
)

Write-Host "Creating symlinks" -foreground "green"

# VsVim & ViEmu
If(!(Test-Path "$env:userprofile\_vsvimrc"))
{
    cmd /c mklink "$env:userprofile\_vsvimrc" "$env:userprofile\winFiles\settings\vsvimrc"
}

If(!(Test-Path "$env:userprofile\_viemurc"))
{
    cmd /c mklink "$env:userprofile\_viemurc" "$env:userprofile\winFiles\settings\viemurc"
}

# GVim
If(!(Test-Path "$env:userprofile\_vimrc"))
{
    cmd /c mklink "$env:userprofile\_vimrc" "$env:userprofile\winFiles\dotfiles\rcs\vimrc"
}

If(!(Test-Path "$env:userprofile\.vimrc.bundles"))
{
    cmd /c mklink "$env:userprofile\.vimrc.bundles" "$env:userprofile\winFiles\dotfiles\rcs\vimrc.bundles"
}

If(!(Test-Path "$env:userprofile\.vimrc.lightline"))
{
    cmd /c mklink "$env:userprofile\.vimrc.lightline" "$env:userprofile\winFiles\dotfiles\rcs\vimrc.lightline"
}

# RipGrep/Ag
If(!(Test-Path "$env:userprofile\.agignore"))
{
    cmd /c mklink "$env:userprofile\.agignore" "$env:userprofile\winFiles\dotfiles\rcs\agignore"
}

If(!(Test-Path "$env:userprofile\.ignore"))
{
    cmd /c mklink "$env:userprofile\.ignore" "$env:userprofile\winFiles\dotfiles\rcs\ignore"
}

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
    cmd /c mklink "$env:userprofile\.gitconfig.user" "$env:userprofile\winFiles\dotfiles\rcs\tag-$installType\gitconfig.user"
}

# Simulate the rcm Post-Up hook - This should be last.
#

Write-Host "Performing post setup tasks" -foreground "green"

If(!(Test-Path "$env:userprofile\.vimscratch"))
{
    New-Item -ItemType Directory -Force -Path "$env:userprofile\.vimscratch"
}

If(!(Test-Path "$env:userprofile\.vimscratch\backup"))
{
    New-Item -ItemType Directory -Force -Path "$env:userprofile\.vimscratch\backup"
}

If(!(Test-Path "$env:userprofile\.vimscratch\swap"))
{
    New-Item -ItemType Directory -Force -Path "$env:userprofile\.vimscratch\swap"
}

If(!(Test-Path "$env:userprofile\.vimscratch\undo"))
{
    New-Item -ItemType Directory -Force -Path "$env:userprofile\.vimscratch\undo"
}

If(!(Test-Path "$env:userprofile\.vim"))
{
    New-Item -ItemType Directory -Force -Path "$env:userprofile\.vim"
}

If(!(Test-Path "$env:userprofile\.vim\autoload"))
{
    New-Item -ItemType Directory -Force -Path "$env:userprofile\.vim\autoload"
}

iwr "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" -UseBasicParsing -o "$env:userprofile\.vim\autoload\plug.vim"

#&"C:\Program Files (x86)\vim\vim80\gvim.exe" -u "$env:userprofile\.vimrc.bundles" +PlugInstall +PlugClean! +qa -

Write-Host "Complete" -foreground "green"
