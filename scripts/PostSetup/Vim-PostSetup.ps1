#!/usr/bin/env powershell.exe

# Setup the support directories
#

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

# Run Vim-Plug to pull the plugins

If(!(Test-Path "$env:userprofile\.vim\autoload\plug.vim"))
{
    Invoke-WebRequest "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" -UseBasicParsing -o "$env:userprofile\.vim\autoload\plug.vim"
    &"$PSScriptRoot\..\..\bin\Update-Vim-Plugins.ps1"
}
