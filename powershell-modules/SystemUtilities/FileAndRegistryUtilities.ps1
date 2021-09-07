#!/usr/bin/env pwsh.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

## Registry
function Set-RegistryBool {
    [CmdletBinding()]
    param(
        [ValidateNotNullorEmpty()]
        [string]$Key,
        [ValidateNotNullorEmpty()]
        [string]$ValueName,
        [bool]$Value
    )

    if ($Value) {
        Set-RegistryValue $Key $ValueName "0" "DWord"
    }
    else {
        Set-RegistryValue $Key $ValueName "1" "DWord"
    }
}

function Set-RegistryInt {
    [CmdletBinding()]
    param(
        [ValidateNotNullorEmpty()]
        [string]$Key,
        [ValidateNotNullorEmpty()]
        [string]$ValueName,
        [int]$Value
    )

    Set-RegistryValue $Key $ValueName $Value "DWord"
}

function Set-RegistryString {
    [CmdletBinding()]
    param(
        [ValidateNotNullorEmpty()]
        [string]$Key,
        [ValidateNotNullorEmpty()]
        [string]$ValueName,
        [string]$Value
    )

    Set-RegistryValue $Key $ValueName $Value "String"
}

function Set-RegistryStringExpand {
    [CmdletBinding()]
    param(
        [ValidateNotNullorEmpty()]
        [string]$Key,
        [ValidateNotNullorEmpty()]
        [string]$ValueName,
        [string]$Value
    )

    Set-RegistryValue $Key $ValueName $Value "ExpandString"
}

function Set-RegistryStringMulti {
    [CmdletBinding()]
    param(
        [ValidateNotNullorEmpty()]
        [string]$Key,
        [ValidateNotNullorEmpty()]
        [string]$ValueName,
        [string[]]$Values
    )

    Set-RegistryValue $Key $ValueName $Values "MultiString"
}

function Set-RegistryValue {
    [CmdletBinding()]
    param(
        [ValidateNotNullorEmpty()]
        [string]$Key,
        [ValidateNotNullorEmpty()]
        [string]$ValueName,
        $Value,
        [ValidateNotNullorEmpty()]
        [string]$DataType
    )

    if ($key.StartsWith("HKCR")) {
        $null = New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
    }

    if (-not (Test-Path $Key)) {
        $null = New-Item -ItemType Directory -Force -Path $Key
    }

    $null = New-ItemProperty -Path $Key -Name $ValueName -Value $Value `
        -PropertyType $DataType -ErrorAction SilentlyContinue

    $null = Set-ItemProperty -Path $Key -Name $ValueName -Value $Value
}

## Taking ownership

function Set-RegistryOwnership {
    [CmdletBinding()]
    param(
        [string]$Key
    )

    # TODO does not work for all root keys yet
    switch ($Key.split('\')[0]) {
        "HKEY_CLASSES_ROOT" {
            $reg = [Microsoft.Win32.Registry]::ClassesRoot
            $Key = $Key.substring(18)
        }
        "HKEY_CURRENT_USER" {
            $reg = [Microsoft.Win32.Registry]::CurrentUser
            $Key = $Key.substring(18)
        }
        "HKEY_LOCAL_MACHINE" {
            $reg = [Microsoft.Win32.Registry]::LocalMachine
            $Key = $Key.substring(19)
        }
    }

    # get administraor group
    $admins = New-Object System.Security.Principal.SecurityIdentifier("S-1-5-32-544")
    $admins = $admins.Translate([System.Security.Principal.NTAccount])

    # set owner
    $Key = $reg.OpenSubKey($Key, "ReadWriteSubTree", "TakeOwnership")
    $acl = $Key.GetAccessControl()
    $acl.SetOwner($admins)
    $Key.SetAccessControl($acl)

    # set FullControl
    $acl = $key.GetAccessControl()
    $rule = New-Object System.Security.AccessControl.RegistryAccessRule($admins, "FullControl", "Allow")
    $acl.SetAccessRule($rule)
    $key.SetAccessControl($acl)
}

function Set-FileOwnership {
    [CmdletBinding()]
    param(
        [ValidateScript( { Test-Path $_ -PathType "Leaf" })]
        [string]$File
    )

    takeown.exe /A /F $File
    $acl = Get-Acl $File

    # get administraor group
    $admins = New-Object System.Security.Principal.SecurityIdentifier("S-1-5-32-544")
    $admins = $admins.Translate([System.Security.Principal.NTAccount])

    # add NT Authority\SYSTEM
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($admins, "FullControl", "None", "None", "Allow")
    $acl.AddAccessRule($rule)

    Set-Acl -Path $File -AclObject $acl
}

function Set-FolderOwnership {
    [CmdletBinding()]
    param(
        [ValidateScript( { Test-Path $_ -PathType "Container" })]
        [string]$Path
    )

    Set-FileOwnership $Path
    foreach ($item in Get-ChildItem $Path) {
        if (Test-Path $item -PathType "Container") {
            Set-FolderOwnership $item.FullName
        }
        else {
            Set-FileOwnership $item.FullName
        }
    }
}
Set-Alias Set-DirectoryOwnership Set-FolderOwnership

# Symbolic links

function New-SymbolicLink {
    [CmdletBinding()]
    param(
        [string]$Link,
        [ValidateScript( { Test-Path $_ -PathType "Leaf" })]
        [string]$Target,
        [switch]$Force
    )

    if ($Force -and (Test-Path $Link)) {
        Remove-Item -Path $Link
    }

    if (-not (Test-Path $Link)) {
        $null = New-Item -ItemType SymbolicLink -Path $Link -Value $Target -Force
    }
}
