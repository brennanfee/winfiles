#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Get-SpecialFolder {
    param(
        [Parameter(Position = 0,
            ParameterSetName = "Alias",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [System.Environment+SpecialFolder]$Alias
    )

    [Environment]::GetFolderPath([System.Environment+SpecialFolder]$Alias)
}

# On Windows, I set a "profile" directory which is usually at one of the drive
# roots.  If a multi-disk system this is usually D:\Profile but for a single
# disk system it would be C:\Profile.  I then put most of the standard folders
# here that comprise my "home".  Due to issues with windows you can't simply
# move the entire C:\User\<username> folder someplace else so my profile serves
# the same purpose but the $HOME and $USERPROFILE are still the User directory.
function Set-ProfileLocation {
    [CmdletBinding(DefaultParameterSetName = "Path", SupportsShouldProcess = $true)]
    param(
        [Parameter(Position = 0,
            ParameterSetName = "Path",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [ValidateScript( { Test-Path $_ -PathType "Container" })]
        [string]
        $Path,
        [switch]$Force = $false
    )

    # May not need this any more with the ValidateScript above, TODO: test
    if (-not (Test-Path $Path)) {
        throw "Path given not valid."
    }

    if ($Force -or [string]::IsNullOrEmpty($env:ProfilePath)) {
        [Environment]::SetEnvironmentVariable("ProfilePath", $Path, "User")
        $env:ProfilePath = $Path
    }
}

function Switch-ToSpecialFolder {
    param(
        [Parameter(Position = 0,
            ParameterSetName = "Alias",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [System.Environment+SpecialFolder]$Alias,
        [Parameter(Position = 1,
            ParameterSetName = "Subfolder",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [string]$Subfolder = ""
    )

    $specialFolder = Get-SpecialFolder $Alias
    if (Test-Path $specialFolder) {
        Switch-ToFolderInternal -RootPath $specialFolder -Subfolder $Subfolder
    }
    else {
        Write-Warning "The Special folder does not exist or is not configured."
    }
}

function Switch-ToProfileFolder {
    param(
        [Parameter(Position = 1,
            ParameterSetName = "Subfolder",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [string]$Subfolder = ""
    )

    if ([string]::IsNullOrEmpty($env:ProfilePath) -or (-not (Test-Path $env:ProfilePath))) {
        Write-Warning "The Profile location has not been set or does not exist.  Set it first and try again."
    }
    else {
        Switch-ToFolderInternal -RootPath $env:ProfilePath -Subfolder $Subfolder
    }
}

function Switch-ToFolderInternal {
    param(
        [ValidateScript( { Test-Path $_ -PathType "Container" })]
        [string]$RootPath,
        [string]$Subfolder = ""
    )

    if ([string]::IsNullOrEmpty($Subfolder)) {
        Set-Location $RootPath
    }
    else {
        $path = Join-Path -Path $RootPath -ChildPath $Subfolder
        if (Test-Path $path) {
            Set-Location $path
        }
        else {
            # See if they asked for a sub-subfolder:  x\y
            if ($Subfolder.Contains([IO.Path]::PathSeparator)) {
                $paths = $Subfolder -split [IO.Path]::PathSeparator
                $path = Join-Path $RootPath -ChildPath $paths[0]
                if (Test-Path $path) {
                    Set-Location $path
                }
                else {
                    Set-Location $RootPath
                }
            }
            else {
                Set-Location $RootPath
            }
        }
    }
}
