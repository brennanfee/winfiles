#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

# Private utilities
function Add-ToPathPrivate {
    [CmdletBinding()]
    param (
        [string] $Variable,
        [ValidateScript({Test-Path $_ -PathType "Container"})]
        [string] $Path,
        [ValidateSet("User", "Machine")]
        [string] $Scope = "User",
        [switch] $Prepend
    )

    if ($Scope -eq "Machine") {
        #$key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
        $key = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
    } else {
        #$key = "HKEY_CURRENT_USER\Environment"
        $key = "HKCU:\Environment"
    }

    #$currentPathString = [Microsoft.Win32.Registry]::GetValue("$key", "$Variable", "")
    $currentPathString = Get-ItemProperty -Path "$key" -Name "$Variable"

    if (-not [string]::IsNullOrEmpty($currentPathString))
    {
        $currentPath = Get-PathVariable -Name "$Variable" -RemoveEmptyPaths -StripQuotes -Target "$Scope"
    } else {
        $currentPath = New-Object System.Collections.ArrayList
    }

    if (-not ($currentPath -contains $Path)) {
        if ($Prepend) {
            Add-PathVariable -Value "$Path" -Name "$Variable" -Prepend -Target "$Scope"
        }
        else {
            Add-PathVariable -Value "$Path" -Name "$Variable" -Target "$Scope"
        }
    }
}

function Remove-FromPathPrivate {
    [CmdletBinding()]
    param (
        [string] $Variable,
        [ValidateScript( { Test-Path $_ -PathType "Container" })]
        [string] $Path,
        [ValidateSet("User", "Machine")]
        [string] $Scope = "User"
    )

    $currentPath = Get-PathVariable -Name "$Variable" -RemoveEmptyPaths -StripQuotes -Target "$Scope"

    if ($currentPath -contains "$Path") {
        $modifiedPath = $currentPath.Remove("$Path")

        Set-PathVariable -Value "$modifiedPath" -Name "Variable" -Target "$Scope"
    }
}

# Standard system "path"

function Add-ToPath {
    [CmdletBinding()]
    param (
        [ValidateScript({Test-Path $_ -PathType "Container"})]
        [string] $Path,
        [ValidateSet("User", "Machine")]
        [string] $Scope = "User",
        [switch] $Prepend
    )

    if ($Prepend) {
        Add-ToPathPrivate -Variable "Path" -Path $Path -Scope $Scope -Prepend
    } else {
        Add-ToPathPrivate -Variable "Path" -Path $Path -Scope $Scope
    }
}

function Remove-FromPath {
    [CmdletBinding()]
    param (
        [ValidateScript({Test-Path $_ -PathType "Container"})]
        [string] $Path,
        [ValidateSet("User", "Machine")]
        [string] $Scope = "User"
    )

    Remove-FromPathPrivate -Variable "Path" -Path $Path -Scope $Scope
}

# PSModulePath - Module load paths for PowerShell

function Add-ToPSModulePath {
    [CmdletBinding()]
    param (
        [ValidateScript( { Test-Path $_ -PathType "Container" })]
        [string] $Path,
        [ValidateSet("User", "Machine")]
        [string] $Scope = "User",
        [switch] $Prepend
    )

    if ($Prepend) {
        Add-ToPathPrivate -Variable "PSModulePath" -Path $Path -Scope $Scope -Prepend
    }
    else {
        Add-ToPathPrivate -Variable "PSModulePath" -Path $Path -Scope $Scope
    }
}

function Remove-FromPSModulePath {
    [CmdletBinding()]
    param (
        [ValidateScript( { Test-Path $_ -PathType "Container" })]
        [string] $Path,
        [ValidateSet("User", "Machine")]
        [string] $Scope = "User"
    )

    Remove-FromPathPrivate -Variable "PSModulePath" -Path $Path -Scope $Scope
}
