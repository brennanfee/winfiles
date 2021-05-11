#!/usr/bin/env pwsh.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Invoke-ExternalPowerShell {
    [CmdletBinding()]
    param(
        [string]$Command,
        [switch]$UseProfile,
        [switch]$Use32Bit,
        [array]$AdditionalArguments
    )

    $arguments = New-Object System.Collections.Generic.List[System.Object]

    if (-not $UseProfile) {
        $arguments.Add("-NoProfile")
    }

    $arguments.AddRange(@(
            "-NonInteractive"
            "-ExecutionPolicy Unrestricted"
        ))

    if ($AdditionalArguments) {
        $arguments.AddRange($AdditionalArguments)
    }

    # Command should always be last as it may have newlines, spaces, etc.
    $arguments.Add('-Command "{0}"' -f $Command)

    $argumentsArray = $arguments.ToArray()

    $powerShellExe = "powershell.exe"
    if ($Use32Bit) {
        $powerShellExe =
        "$env:SystemRoot\SysWOW64\WindowsPowerShell\v1.0\powershell.exe"
    }

    Start-Process -Wait -NoNewWindow -FilePath $powerShellExe `
        -ArgumentList $argumentsArray
}

function Invoke-ExternalPowerShellCore {
    [CmdletBinding()]
    param(
        [string]$Command,
        [switch]$UseProfile,
        [array]$AdditionalArguments
    )

    $arguments = New-Object System.Collections.Generic.List[System.Object]

    if (-not $UseProfile) {
        $arguments.Add("-NoProfile")
    }

    $arguments.AddRange(@(
            "-NonInteractive"
            "-ExecutionPolicy Unrestricted"
        ))

    if ($AdditionalArguments) {
        $arguments.AddRange($AdditionalArguments)
    }

    # Command should always be last as it may have newlines, spaces, etc.
    $arguments.Add('-Command "{0}"' -f $Command)

    $argumentsArray = $arguments.ToArray()

    # These are in order of preference
    $pathsToCheck = @(
        "$env:ProgramFiles\PowerShell\7\pwsh.exe"
        "$env:ProgramFiles\PowerShell\6\pwsh.exe"
    )

    $psCoreExe = "NotFound"
    foreach ($pathToCheck in $pathsToCheck) {
        if (Test-Path $pathToCheck) {
            $psCoreExe = $pathToCheck
            break
        }
    }
    if ($psCoreExe -eq "NotFound") {
        Write-Error "Unable to locate PowerShell Core"
    }
    else {
        Start-Process -Wait -NoNewWindow -FilePath $psCoreExe `
            -ArgumentList $argumentsArray
    }
}

function Invoke-ExternalCommand {
    [CmdletBinding()]
    param(
        [array]$Arguments
    )

    $cmdExe = "$env:ComSpec"

    Start-Process -Wait -NoNewWindow -FilePath $cmdExe -ArgumentList $Arguments
}
