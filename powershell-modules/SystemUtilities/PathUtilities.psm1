#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Add-ToPath {
    [CmdletBinding()]
    param (
        [ValidateScript({Test-Path $_ -PathType "Container"})]
        [string] $Path,
        [ValidSet("User", "Machine")]
        [string] $Scope = "User",
        [switch] $Prepend
    )

    $currentPath = Get-PathVariable -Name "Path" -RemoveEmptyPaths -StripQuotes -Target "$Scope"

    if (-not ($currentPath -contains $Path))
    {
        if ($Prepend) {
            Add-PathVariable -Value "$Path" -Name "Path" -Prepend -Target "$Scope"
        } else {
            Add-PathVariable -Value "$Path" -Name "Path" -Target "$Scope"
        }
    }
}

function Remove-FromPath {
    [CmdletBinding()]
    param (
        [ValidateScript({Test-Path $_ -PathType "Container"})]
        [string] $Path,
        [ValidSet("User", "Machine")]
        [string] $Scope = "User"
    )

    $currentPath = Get-PathVariable -Name "Path" -RemoveEmptyPaths -StripQuotes -Target "$Scope"

    if ($currentPath -contains "$Path")
    {
        $modifiedPath = $currentPath.Remove("$Path")

        Set-PathVariable -Value "$modifiedPath" -Name "Path" -Target "$Scope"
    }
}
