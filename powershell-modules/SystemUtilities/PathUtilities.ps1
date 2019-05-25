#!/usr/bin/env pwsh.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

# Private utilities
function Get-CurrentPathValuePrivate {
    [CmdletBinding()]
    param (
        [string] $Variable,
        [ValidateSet("User", "Machine")]
        [string] $Scope = "User"
    )

    if ($Scope -eq "Machine") {
        $key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
    } else {
        $key = "HKEY_CURRENT_USER\Environment"
    }

    $currentPathString = [Microsoft.Win32.Registry]::GetValue("$key", "$Variable", "")

    if (-not [string]::IsNullOrEmpty($currentPathString))
    {
        $currentPath = Get-PathVariable -Name "$Variable" -RemoveEmptyPaths -StripQuotes -Target "$Scope"
    } else {
        $currentPath = New-Object System.Collections.ArrayList
    }

    return $currentPath
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

    $currentPath = Get-CurrentPathValuePrivate -Variable "$Path" -Scope "$Scope"

    if (-not ($currentPath -contains "$Path")) {
        if ($Prepend) {
            Add-PathVariable -Value "$Path" -Name "Path" -Prepend -Target "$Scope"
        }
        else {
            Add-PathVariable -Value "$Path" -Name "Path" -Target "$Scope"
        }
    }
}

function Remove-FromPath {
    [CmdletBinding()]
    param (
        [ValidateScript( { Test-Path $_ -PathType "Container" })]
        [string] $Path,
        [ValidateSet("User", "Machine")]
        [string] $Scope = "User"
    )

    $currentPath = Get-CurrentPathValuePrivate -Variable "Path" -Scope "$Scope"

    if ($currentPath -contains "$Path") {
        $modifiedPath = $currentPath.Remove("$Path")

        Set-PathVariable -Value "$modifiedPath" -Name "Path" -Target "$Scope"
    }
}
