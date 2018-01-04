#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version Latest

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Path -Parent)

$BinFolder = Join-Path (Get-Item (Get-Location)).parent.FullName "bin"
$ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Path -Parent

$env:PSModulePath = "$ScriptDir;" + "$ScriptDir\TodayTechTools;" + "$env:PSModulePath"
$global:PsGetDestinationModulePath = $ScriptDir

# Set filesystem providers home location
$provider = get-psprovider FileSystem
$provider.Home = $env:userprofile
$env:home = $env:userprofile
Set-Variable -name HOME -value $env:home -Force

Write-Host -ForegroundColor 'Green' "Importing third-party modules..."
Import-Module PSReadLine
Import-Module Pscx -arg "$ScriptDir\Pscx.UserPreferences.ps1"
Import-Module posh-docker

Import-Module posh-git
$global:GitPromptSettings.EnableWindowTitle = $true
$global:GitPromptSettings.DefaultForegroundColor = "white"

#Import-Module posh-npm

Write-Host -ForegroundColor 'Green' "Importing custom modules..."
Import-Module EnvironmentTools
#Import-Module VisualStudioTools -DisableNameChecking
Import-Module CustomPrompt
Import-Module Aliases

Write-Host -ForegroundColor 'Green' "Modules imported."

# Set the WinFilesRoot environment variable (if not already set)
#Set-WinFilesRoot

# Add the editor environment variables if not already set
if ([string]::IsNullOrEmpty($env:EDITOR))
{
    Set-DefaultEditor
}

# Set the DIRCMD environment variable if not already set
if ([string]::IsNullOrEmpty($env:DIRCMD))
{
    Set-DirCmd
}

# Set the TERM environment variable if not already set
#if ([string]::IsNullOrEmpty($env:TERM))
#{
#    Set-Terminal
#}

# Set the VIMRUNTIME environment variable, if needed
if ([string]::IsNullOrEmpty($env:VIMRUNTIME))
{
    Set-VimEnvironmentToDefault
}

# Set the VIM environment variable, if needed
if ([string]::IsNullOrEmpty($env:VIM))
{
    Set-VimEnvironmentToDefault
}

# Add bin folder to the environment path
Add-ToPath($BinFolder)

# Add the Git path to the environment path
Add-GitToPath

# Add the Vim path to the environment path
# $vimBatchPath = Get-DefaultVimBatchPath
# if (-not ([string]::IsNullOrEmpty($vimBatchPath))) {
#     Add-ToPath($vimBatchPath)
# }

# Add the editor's path to the environment path
Add-ToPath([System.IO.Path]::GetDirectoryName($env:EDITOR))

# Set the visual studio environment
# TODO: DO I NEED THIS ANY MORE?
#Set-VsVars32 2017

# Set the editor for PowerShell Extensions Edit-File function
$Pscx:Preferences['TextEditor'] = $env:EDITOR

# Load last saved history list
.\PsHistory\SaveAndLoadHistory.ps1

Pop-Location
