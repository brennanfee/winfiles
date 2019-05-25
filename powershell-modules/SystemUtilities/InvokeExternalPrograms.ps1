#!/usr/bin/env pwsh.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Invoke-ExternalPowerShell {
    [CmdletBinding()]
    param(
        [string]$Command,
        [switch]$UseProfile,
        [switch]$Use32Bit
    )

    $arguments = New-Object System.Collections.Generic.List[System.Object]

    if (-not $UseProfile) {
        $arguments.Add("-NoProfile")
    }

    $arguments.AddRange(@(
            "-NonInteractive"
            "-ExecutionPolicy Unresctricted"
            ('-Command "{0}"' -f $Command)
        ))

    $powerShellExe = "powershell.exe"
    if ($Use32Bit) {
        $powerShellExe =
        "$env:SystemRoot\SysWOW64\WindowsPowerShell\v1.0\powershell.exe"
    }

    Start-Process -Wait -NoNewWindow -FilePath $powerShellExe `
        -ArgumentList $arguments.ToArray
}

function Invoke-ExternalPowerShellCore {
    [CmdletBinding()]
    param(
        [string]$Command,
        [switch]$UseProfile
    )

    $arguments = New-Object System.Collections.Generic.List[System.Object]

    if (-not $UseProfile) {
        $arguments.Add("-NoProfile")
    }

    $arguments.AddRange(@(
            "-NonInteractive"
            "-ExecutionPolicy Unresctricted"
            ('-Command "{0}"' -f $Command)
        ))

    $psCoreExe = "$env:ProgramFiles\PowerShell\6\pwsh.exe"

    Start-Process -Wait -NoNewWindow -FilePath $psCoreExe `
        -ArgumentList $arguments.ToArray
}

function Invoke-ExternalCommand {
    [CmdletBinding()]
    param(
        [array]$Arguments
    )

    $cmdExe = "$env:ComSpec"

    Start-Process -Wait -NoNewWindow -FilePath $cmdExe -ArgumentList $Arguments
}
