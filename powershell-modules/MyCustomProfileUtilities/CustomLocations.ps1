#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Set-MyCustomProfileLocation {
    $DriveCount = (Get-PhysicalDisk | Measure-Object).Count

    $profilesPath="C:\profile"
    if ($DriveCount -ge 2) {
        $profilesPath="D:\profile"
    }

    Set-ProfileLocation $profilesPath
}

function Switch-ToDocumentsLocation {
    Switch-ToProfileFolder "documents"
}

function Switch-ToDownloadsLocation {
    Switch-ToProfileFolder "downloads"
}

function Switch-ToDropboxLocation {
    Switch-ToProfileFolder "dropbox"
}

function Switch-ToMountsLocation {
    Switch-ToProfileFolder "mounts"
}

function Switch-ToPublicLocation {
    Switch-ToProfileFolder "public"
}

function Switch-ToSourceLocation {
    Switch-ToProfileFolder "source"
}

function Switch-ToSourcePersonalLocation {
    Switch-ToProfileFolder "source\personal"
}

function Switch-ToSourceGithubLocation {
    Switch-ToProfileFolder "source\github"
}

function Switch-ToWinFilesLocation {
    Switch-ToProfileFolder "winfiles"
}
