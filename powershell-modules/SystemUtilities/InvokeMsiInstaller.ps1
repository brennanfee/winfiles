#!/usr/bin/env pwsh.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Invoke-MsiInstaller {
    [CmdletBinding()]
    param(
        [ValidateScript( { Test-Path $_ -PathType "Leaf" })]
        [string]$Msi,
        [string]$LogFile = "",
        [array]$AdditionalArguments
    )

    $installer = [System.IO.Path]::GetFileNameWithoutExtension($Msi) +
    [System.IO.Path]::GetExtension($Msi)

    Write-Host "Installing $installer"
    if ([string]::IsNullOrEmpty($LogFile)) {
        $LogFile = Get-LogFile "msi-$installer.log"
    }

    $arguments = New-Object System.Collections.Generic.List[System.Object]

    $arguments.AddRange(@(
            "/i"
            ('"{0}"' -f $Msi)
            "/qn"
            "/norestart"
            "/L*v+"
            ('"{0}"' -f $LogFile)
        ))

    $arguments.AddRange($AdditionalArguments)

    Start-Process -Wait -NoNewWindow -FilePath "msiexec.exe" `
        -ArgumentList $arguments.ToArray()
}

function Invoke-MsiInstallerFromUrl {
    [CmdletBinding()]
    param(
        [string]$Url,
        [string]$LogFile = "",
        [array]$AdditionalArguments
    )

    $installer = [System.IO.Path]::GetFileNameWithoutExtension($Msi) +
    [System.IO.Path]::GetExtension($Msi)

    $tempFileName = [System.IO.Path]::GetTempFileName();

    Write-Host "Downloading $installer"
    Invoke-WebRequest $Url -UseBasicParsing -o $tempFileName

    Invoke-MsiInstaller $tempFileName $LogFile $AdditionalArguments
}
