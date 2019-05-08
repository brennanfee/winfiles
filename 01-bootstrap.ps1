#!/usr/bin/env powershell.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

### 01 - Set the PowerShell execution policy
# $policy = 'Unrestricted'
$policy = 'RemoteSigned'

Set-ExecutionPolicy $policy -scope CurrentUser

if (Is64Bit) {
  Start-Process "$env:SystemRoot\SysWOW64\WindowsPowerShell\v1.0\powershell.exe" -verb runas -wait -argumentList "-noprofile -WindowStyle hidden -noninteractive -ExecutionPolicy unrestricted -Command `"Set-ExecutionPolicy $policy`""
} else {
  Start-Process "powershell.exe" -verb runas -wait -argumentList "-noprofile -noninteractive -ExecutionPolicy unrestricted -WindowStyle hidden -Command `"Set-ExecutionPolicy $policy`""
}

function Is64Bit {  [IntPtr]::Size -eq 8  }

### 02 - Enable WinRM and PS Remoting
Enable-PSRemoting -force

### 03 - Set the PSGallery as trusted
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

### 04 - Update Existing Modules
Install-Module -Name PowerShellGet -Scope AllUsers -Force
# Reload the module
Remove-Module -Name PowerShellGet
Import-Module -Name PowerShellGet -MinimumVersion 2.1.2

# Install the others
#Install-Module -Name PSDscResources -AcceptLicense -Scope AllUsers -Force
Install-Module -Name Pester -AcceptLicense -Scope AllUsers -Force -SkipPublisherCheck
Install-Module -Name PSReadLine -AllowPrerelease -AcceptLicense -Scope AllUsers -Force

### 05 - Install New Modules
#Install-Module -Name ComputerManagementDsc -AcceptLicense -Scope AllUsers -Force
#Install-Module -Name NetworkingDsc -AcceptLicense -Scope AllUsers -Force
#Install-Module -Name cGit -AcceptLicense -Scope AllUsers -Force
# vscode
# cAppxPackage
# DSCR_Font
# cdownloadfile
# xDownloadFile
# FileDownlaodDSC
# OneDriveDsc - only if you can uninstall\disable it
# HardenedDSC
# ExePackage
# DSCR_PythonPackage
# DSCR_FileAssoc
# DSCR_FileContent
# LCMRebootNodeIfNeeded
# xRemoteDesktopAdmin
# FileContentDsc
# VisualStudioDSC
# xDismFeature
# xChrome
# xFirefox
# DSCR_Firefox
# DSCR_Application
# DSCR_Shortcut
# DSCR_PowerPlan
# DSCR_Font
# DSCR_AppxPackage
# DSCR_MSLicense

#

#######

# chocolatey -> if going to continue using chocolatey
# BetterCredentials -AllowClobber

#Install-Module -Name Pscx -AllowClobber -AcceptLicense -Scope CurrentUser
#Install-Module -Name posh-git -AllowClobber -AcceptLicense -Scope CurrentUser
#Install-Module -Name posh-docker -AcceptLicense -Scope CurrentUser
# AWSPowerShell
# AWSPowerShell.NetCore -> if using powershell core
# PendingReboot
# JiraPS
# PSJira
# DockerProvider
# BurntToast
# oh-my-posh
# BitbucketServerAutomation
# Invoke-MsBuild
# PSFolderSize
# PowerLine
# PANSIES -AllowClobber
# PowerShellForGitHub
# ConfluencePS
# AWSLambdaPSCore
# PoshRegistry
# GitHubProvider
# GistProvider
# vim -> open files in gvim
# PSStringTemplate
# Emojis
# SemVer  ( ps-csproj )
# WallpaperManager
# MarkdownToHtml
# PSGitHub
# posh-tex
# VCVars
# GitLab-API
# PSGitLab
# PowershellBGInfo
# Bash
# Recycle
# ConversionModule

### Scoop

# scoop install sudo 7zip git which --global
# scoop bucket add extras
# scoop install which aria2 curl grep sed less touch
# scoop install python ruby go perl...
# scoop install vim
