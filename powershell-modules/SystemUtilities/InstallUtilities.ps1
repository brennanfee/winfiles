#!/usr/bin/env pwsh.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

$global:installCount = $null

function Install-WithChocolatey {
    [CmdletBinding()]
    param(
        [string]$Application,
        [string]$PackageParameters = "",
        [string]$InstallArguments = "",
    )

    Write-Host "Installing $Application with Chocolatey"
    $arguments = New-Object System.Collections.Generic.List[System.Object]

    $arguments.Add("-y")
    $arguments.Add("-r")
    $arguments.Add("--skip-virus-check")
    $arguments.Add("--accept-license")
    $arguments.Add("--no-progress")

    if (-not [string]::IsNullOrEmpty($PackageParameters)) {
        $arguments.Add("--package-parameters=`"${PackageParameters}`"")
    }

    if (-not [string]::IsNullOrEmpty($InstallArguments)) {
        $arguments.Add("--install-arguments=`"${InstallArguments}`"")
    }

    $arguments.Add($Application)

    $argumentsArray = $arguments.ToArray()

    Start-Process -Wait -NoNewWindow -FilePath "choco.exe" `
        -ArgumentList $argumentsArray
}

function Install-WithChocolateyList {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Path to a file with a list of applications")]
        [ValidateScript( { Test-Path $_ })]
        [string]$ListFile,
        [Parameter(Position = 1, ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Timeout between application installs, in minutes (default 1)")]
        [int]$Timeout = 1,
        [Parameter(Position = 2, ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Number of installs between which an extra delay will be added (default 10)")]
        [int]$SetDelayCount = 10,
        [Parameter(Position = 1, ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Timeout to add between a set of applications, in minutes (default 5)")]
        [int]$SetDelayTimeout = 5
    )

    ## TODO: Could add a more sophisticated file format that allows passing package and install arguments

    $applications = Get-Content $ListFile

    foreach ($application in $applications) {
        ## If the global is null, initialized it
        $global:installCount ?? $global:installCount = 0

        # Skip blank lines
        if ([string]::IsNullOrEmpty($application)) {
            continue
        }
        # Skip comments
        if ($application.StarsWith("#")) {
            continue
        }

        Install-WithChocolatey $application

        if ($Timeout -gte 1) {
            Start-Sleep -Seconds ($Timeout * 60)
        }

        $global:installCount++;
        if ($SetDelayCount -gte 1 -and $global:installCount -gte $SetDelayCount) {
            $global:installCount = 0
            Start-Sleep -Seconds ($SetDelayTimeout * 60)
        }
        else {
            if ($Timeout -gte 1) {
                Start-Sleep -Seconds ($Timeout * 60)
            }
        }
    }
}
