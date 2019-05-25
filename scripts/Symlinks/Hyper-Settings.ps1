#!/usr/bin/env pwsh.exe
Set-StrictMode -Version Latest

Import-Module -DisableNameChecking "$PSScriptRoot\..\Utilities\FileAndRegistryUtilities.psm1"

Make-Link "$env:userprofile\.hyper.js" "$env:userprofile\winFiles\settings\hyper.js"
Make-Link "$env:userprofile\.hyper.css" "$env:userprofile\winFiles\dotfiles\rcs\hyper.css"
