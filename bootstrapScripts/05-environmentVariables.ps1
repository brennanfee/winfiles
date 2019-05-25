#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Setting up environment variables"

Set-MyCustomProfileLocation
Set-HomeEnvironmentVariable
Set-DefaultEditor

# Set DIRCMD
$value = "/p /o:gn"
[Environment]::SetEnvironmentVariable("DIRCMD", "$value", "User")
$env:DIRCMD = "$value"

# Set WIN_USER
$value = "%USERNAME%"
[Environment]::SetEnvironmentVariable("WIN_USER", "$value", "User")
$env:WIN_USER = "$value"

# Set WSLENV
$value = "TMP/up:USERPROFILE/up:WIN_USER"
[Environment]::SetEnvironmentVariable("WSLENV", "$value", "User")
$env:WIN_USER = "$value"

# Docker
$value = "linux"
[Environment]::SetEnvironmentVariable("DOCKER_DEFAULT_PLATFORM", "$value", "User")
$env:DOCKER_DEFAULT_PLATFORM = "$value"
[Environment]::SetEnvironmentVariable("LCOW_API_PLATFORM_IF_OMITTED", "$value", "User")
$env:LCOW_API_PLATFORM_IF_OMITTED = "$value"

# Python pipenv
$value = "1"
[Environment]::SetEnvironmentVariable("PIPENV_VENV_IN_PROJECT", "$value", "User")
$env:PIPENV_VENV_IN_PROJECT = "$value"
