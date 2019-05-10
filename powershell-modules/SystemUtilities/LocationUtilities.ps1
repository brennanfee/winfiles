#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Get-SpecialFolder {
  param(
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
    [CmdletBinding(DefaultParameterSetName="Path", SupportsShouldProcess=$true)]
    param(
        [Parameter(Position=0,
                   ParameterSetName="Path",
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [ValidateScript({Test-Path $_ -PathType "Container"})]
        [string]
        $Path
    )

    # May not need this any more with the ValidateScript above, TODO: test
    if (-not (Test-Path $Path)) {
        throw "Path given not valid."
    }

    [Environment]::SetEnvironmentVariable("ProfilePath", $Path, "User")
    $env:ProfilePath = $Path
}

function Switch-ToSpecialFolder {
    param(
        [System.Environment+SpecialFolder]$Alias
    )

    $specialFolder = Get-SpecialFolder $Alias
    if (Test-Path $specialFolder) {
        Set-Location $specialFolder
    }
}

function Switch-ToProfileFolder {
    param(
        [string]$Folder
    )

    # TODO: Erorr handling when $env:ProfilePath is invalid

    $path = Join-Path -Path $env:ProfilePath -ChildPath $Folder
    if (Test-Path $path) {
        Set-Location $path
    }
}

function Switch-ToHomeLocation {
    Switch-ToSpecialFolder "UserProfile"
}

function Switch-ToDesktopLocation {
    Switch-ToSpecialFolder "DesktopDirectory"
}

function Switch-ToMyDocumentsLocation {
    Switch-ToSpecialFolder "MyDocuments"
}

function Switch-ToMusicLocation {
    Switch-ToSpecialFolder "MyMusic"
}

function Switch-ToPicturesLocation {
    Switch-ToSpecialFolder "MyPictures"
}

function Switch-ToTemplatesLocation {
    # Might not be what I want.  TODO: Test
    Switch-ToSpecialFolder "Templates"
}

function Switch-ToVideosLocation {
    Switch-ToSpecialFolder "MyVideos"
}
