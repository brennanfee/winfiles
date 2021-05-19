#!/usr/bin/env pwsh.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

$global:installCount = $null

function Install-WithChocolatey {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Name of the application (chocolatey package) to install")]
        [string]$Application,
        [Parameter(Position = 1, ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Additional package parameters to pass to the core installer.")]
        [string]$PackageParameters = "",
        [Parameter(Position = 2, ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Additional install arguments to pass to the Chocolatey script.")]
        [string]$InstallArguments = "",
        [Parameter(Position = 3, ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Path to an output file to log the install progress.")]
        [string]$LogFile = ""
    )

    if ([string]::IsNullOrEmpty($LogFile)) {
        $LogFile = Get-LogFile "choco-$Application.log"
    }

    Write-Host "Installing $Application with Chocolatey"
    $arguments = New-Object System.Collections.Generic.List[System.Object]

    $arguments.Add("install")
    $arguments.Add("-y")
    $arguments.Add("-r")
    $arguments.Add("--skip-virus-check")
    $arguments.Add("--accept-license")
    $arguments.Add("--log-file=`"${LogFile}`"")
    $arguments.Add("--no-progress")

    if (-not [string]::IsNullOrEmpty($PackageParameters)) {
        $arguments.Add("--package-parameters=`"${PackageParameters}`"")
    }

    if (-not [string]::IsNullOrEmpty($InstallArguments)) {
        $arguments.Add("--install-arguments=`"${InstallArguments}`"")
    }

    $arguments.Add($Application)

    $argumentsArray = $arguments.ToArray()

    Start-Process -Wait -NoNewWindow -FilePath "choco.exe" -ArgumentList $argumentsArray
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
            HelpMessage = "Timeout between application installs, in seconds (default 15)")]
        [int]$Timeout = 15,
        [Parameter(Position = 2, ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Number of installs between which an extra delay will be added (default 10)")]
        [int]$SetDelayCount = 10,
        [Parameter(Position = 3, ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Timeout to add between a set of applications, in minutes (default 3)")]
        [int]$SetDelayTimeout = 3
    )

    ## TODO: Could add a more sophisticated file format that allows passing package and install arguments

    $applications = Get-Content -Path $ListFile

    foreach ($appObject in $applications) {
        $application = [string]$appObject
        Write-Host "---"
        Write-Host "Working on ${application}"

        ## If the global is null, initialized it
        if ($global:installCount -eq $null) {
            $global:installCount = 0
        }
        Write-Host "global install count: ${global:installCount}"

        # Skip blank lines
        if ([string]::IsNullOrEmpty($application)) {
            Write-Host "Skipping an empty line"
            continue
        }

        # Skip comments
        if ($application.StartsWith("#")) {
            Write-Host "Skipping an comment line"
            continue
        }

        # Install the app
        Install-WithChocolatey $application

        # Sleep for a bit
        $global:installCount++;
        if ($SetDelayCount -ge 1 -and $global:installCount -ge $SetDelayCount) {
            $global:installCount = 0
            Write-Host "Sleeping for ${SetDelayTimeout} minutes (delay between set)."
            Start-Sleep -Seconds ($SetDelayTimeout * 60)
        }
        else {
            if ($Timeout -ge 1) {
                Write-Host "Sleeping for ${Timeout} seconds."
                Start-Sleep -Seconds ($Timeout)
            }
        }
    }
}
