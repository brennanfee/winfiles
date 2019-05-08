#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Set-Editor {
    [CmdletBinding(DefaultParameterSetName="Path", SupportsShouldProcess=$true)]
    param(
        [Parameter(Position=0,
                   ParameterSetName="Path",
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [ValidateScript({Test-Path $_})]
        [string]
        $Path
    )

    # May not need this any more with the ValidateScript above, TODO: test
    if (-not (Test-Path $Path)) {
        throw "File given not valid."
    }

    [Environment]::SetEnvironmentVariable("EDITOR", $Path, "User")
    $env:editor = $Path
    $Pscx:Preferences['TextEditor'] = $env:editor
}

function Set-DefaultEditor {
    # My preferred order of precedence (currently): Vim, Visual Studio Code, Notepad
    if (-not (Set-EditorToVim))
    {
        if (-not (Set-EditorToVSCode))
        {
            Set-EditorToNotepad
        }
    }
}

function Set-EditorToVim {
    $editor = Get-DefaultVimExe
    if (-not ([string]::IsNullOrEmpty($editor))) {
        Write-Host -ForegroundColor 'Green' "Setting editor to Vim: $editor"
        Set-Editor($editor)
        return $true
    }
    else {
        Write-Host -ForegroundColor 'Red' "Unable to locate Vim"
        return $false
    }
}

function Set-EditorToVSCode {
    $editor = Get-DefaultVSCodeExe
    if (-not ([string]::IsNullOrEmpty($editor))) {
        Write-Host -ForegroundColor 'Green' "Setting editor to VS Code: $editor"
        Set-Editor($editor)
        return $true
    }
    else {
        Write-Host -ForegroundColor 'Red' "Unable to locate VS Code"
        return $false
    }
}

function Set-EditorToNotepad {
    Write-Host -ForegroundColor 'Green' "Setting editor to notepad."
    Set-Editor("C:\Windows\system32\notepad.exe")
    return $true
}
