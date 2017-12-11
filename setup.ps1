#!/usr/bin/env powershell

# Create links for settings files
#

Param(
    [Parameter(Position=0)]
    [ValidateSet('home','work')]
    [string] $installType = "home"
)

# VsVim & ViEmu
cmd /c mklink "$env:userprofile\_vsvimrc" "$env:userprofile\winFiles\settings\vsvimrc"
cmd /c mklink "$env:userprofile\_viemurc" "$env:userprofile\winFiles\settings\viemurc"

# GVim
cmd /c mklink "$env:userprofile\_vimrc" "$env:userprofile\winFiles\dotfiles\rcs\vimrc"
cmd /c mklink "$env:userprofile\.vimrc.bundles" "$env:userprofile\winFiles\dotfiles\rcs\vimrc.bundles"
cmd /c mklink "$env:userprofile\.vimrc.lightline" "$env:userprofile\winFiles\dotfiles\rcs\vimrc.lightline"

cmd /c mklink "$env:userprofile\.agignore" "$env:userprofile\winFiles\dotfiles\rcs\agignore"
cmd /c mklink "$env:userprofile\.ignore" "$env:userprofile\winFiles\dotfiles\rcs\ignore"

# Git
cmd /c mklink "$env:userprofile\.gitconfig" "$env:userprofile\winFiles\dotfiles\rcs\gitconfig"
cmd /c mklink "$env:userprofile\.gitconfig.os" "$env:userprofile\winFiles\settings\gitconfig.os"
cmd /c mklink "$env:userprofile\.gitconfig.user" "$env:userprofile\winFiles\dotfiles\rcs\tag-$installType\gitconfig.user"

# Simulate the rcm Post-Up hook - This should be last.
#

mkdir "$env:userprofile\.vimscratch"
mkdir "$env:userprofile\.vimscratch\backup"
mkdir "$env:userprofile\.vimscratch\swap"
mkdir "$env:userprofile\.vimscratch\undo"

mkdir "$env:userprofile\.vim"
mkdir "$env:userprofile\.vim\autoload"
iwr "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" -UseBasicParsing -o "$env:userprofile\.vim\autoload\plug.vim"

cmd /c "C:\Program Files (x86)\vim\vim80\gvim.exe" -u "$env:userprofile\.vimrc.bundles" +PlugInstall +PlugClean! +qa -

