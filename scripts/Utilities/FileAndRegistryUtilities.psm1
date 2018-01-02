#!/usr/bin/env powershell.exe
#Requires -Version 5

## Registry
function Set-RegistryInt($key, $valueName, $value) {
    Set-RegistryValue $key $valueName $value DWord
}

function Set-RegistryString($key, $valueName, $value) {
    Set-RegistryValue $key $valueName $value String
}

function Set-RegistryValue($key, $valueName, $value, $dataType)
{
    if (!(Test-Path $key)) {
        New-Item -ItemType Directory -Force -Path $key
    }
    New-ItemProperty -Path $key -Name $valueName -Value $value -PropertyType $dataType -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $key -Name $valueName -Value $value
}

## Taking ownership

function Takeown-Registry($key) {
    # TODO does not work for all root keys yet
    switch ($key.split('\')[0]) {
        "HKEY_CLASSES_ROOT" {
            $reg = [Microsoft.Win32.Registry]::ClassesRoot
            $key = $key.substring(18)
        }
        "HKEY_CURRENT_USER" {
            $reg = [Microsoft.Win32.Registry]::CurrentUser
            $key = $key.substring(18)
        }
        "HKEY_LOCAL_MACHINE" {
            $reg = [Microsoft.Win32.Registry]::LocalMachine
            $key = $key.substring(19)
        }
    }

    # get administraor group
    $admins = New-Object System.Security.Principal.SecurityIdentifier("S-1-5-32-544")
    $admins = $admins.Translate([System.Security.Principal.NTAccount])

    # set owner
    $key = $reg.OpenSubKey($key, "ReadWriteSubTree", "TakeOwnership")
    $acl = $key.GetAccessControl()
    $acl.SetOwner($admins)
    $key.SetAccessControl($acl)

    # set FullControl
    $acl = $key.GetAccessControl()
    $rule = New-Object System.Security.AccessControl.RegistryAccessRule($admins, "FullControl", "Allow")
    $acl.SetAccessRule($rule)
    $key.SetAccessControl($acl)
}

function Takeown-File($path) {
    takeown.exe /A /F $path
    $acl = Get-Acl $path

    # get administraor group
    $admins = New-Object System.Security.Principal.SecurityIdentifier("S-1-5-32-544")
    $admins = $admins.Translate([System.Security.Principal.NTAccount])

    # add NT Authority\SYSTEM
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($admins, "FullControl", "None", "None", "Allow")
    $acl.AddAccessRule($rule)

    Set-Acl -Path $path -AclObject $acl
}

function Takeown-Folder($path) {
    Takeown-File $path
    foreach ($item in Get-ChildItem $path) {
        if (Test-Path $item -PathType Container) {
            Takeown-Folder $item.FullName
        } else {
            Takeown-File $item.FullName
        }
    }
}

# Symbolic links

function Make-Link-Safe($link, $target)
{
    # This version will not do anything if the a link or file already exists
    # at the link point
    If (!(Test-Path("$link")))
    {
        cmd /c mklink "$link" "$target"
    }
}

function Make-Link($link, $target)
{
    # This version will first remove the link or file if it exists and will
    # then re-create the link
    If (Test-Path("$link"))
    {
        Remove-Item -Path "$link"
    }

    cmd /c mklink "$link" "$target"
}
