#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Set-Editor {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [ValidateScript( { Test-Path $_ })]
        [string]
        $Path
    )

    # May not need this any more with the ValidateScript above, TODO: test
    if (-not (Test-Path $Path)) {
        throw "File given not valid."
    }

    [Environment]::SetEnvironmentVariable("EDITOR", $Path, "User")
    $env:EDITOR = $Path
    $Pscx:Preferences['TextEditor'] = $env:EDITOR
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

function Set-EditorToEmacs {
    $editor = Get-DefaultEmacsExe
    if (-not ([string]::IsNullOrEmpty($editor))) {
        Write-Host -ForegroundColor 'Green' "Setting editor to Emacs: $editor"
        Set-Editor($editor)
        return $true
    }
    else {
        Write-Host -ForegroundColor 'Red' "Unable to locate Emacs"
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

function Set-EditorToSublime {
    $editor = Get-DefaultSublimeTextExe
    if (-not ([string]::IsNullOrEmpty($editor))) {
        Write-Host -ForegroundColor 'Green' "Setting editor to Sublime Text: $editor"
        Set-Editor($editor)
        return $true
    }
    else {
        Write-Host -ForegroundColor 'Red' "Unable to locate Sublime Text Editor"
        return $false
    }
}

function Set-EditorToAtom {
    $editor = Get-DefaultAtomExe
    if (-not ([string]::IsNullOrEmpty($editor))) {
        Write-Host -ForegroundColor 'Green' "Setting editor to Atom: $editor"
        Set-Editor($editor)
        return $true
    }
    else {
        Write-Host -ForegroundColor 'Red' "Unable to locate Atom"
        return $false
    }
}
function Set-EditorToNotepad {
    Write-Host -ForegroundColor 'Green' "Setting editor to notepad."
    Set-Editor("C:\Windows\system32\notepad.exe")
    return $true
}

# Internal methods to find editor exe's

function Get-DefaultSublimeTextExe {
    if (Test-Path "C:\Program Files\Sublime Text 3\sublime_text.exe") {
        return "C:\Program Files\Sublime Text 3\sublime_text.exe"
    }
    elseif (Test-Path "C:\Program Files (x86)\Sublime Text 3\sublime_text.exe") {
        return "C:\Program Files (x86)\Sublime Text 3\sublime_text.exe"
    }
    else {
        return ""
    }
}

function Get-DefaultAtomExe {
    if (Test-Path "$env:LOCALAPPDATA\atom\atom.exe") {
        return "$env:LOCALAPPDATA\atom\atom.exe"
    }
    else {
        return ""
    }
}

function Get-DefaultVSCodeExe {
    if (Test-Path "$env:LOCALAPPDATA\Programs\Microsoft VS Code\Code.exe") {
        return "$env:LOCALAPPDATA\Programs\Microsoft VS Code\Code.exe"
    }
    elseif (Test-Path "C:\Program Files\Microsoft VS Code\Code.exe") {
        return "C:\Program Files\Microsoft VS Code\Code.exe"
    }
    elseif (Test-Path "C:\Program Files (x86)\Microsoft VS Code\Code.exe") {
        return "C:\Program Files (x86)\Microsoft VS Code\Code.exe"
    }
    else {
        return ""
    }
}

function Get-DefaultVimExe {
    ## Check for scoop first...
    if (-not ([string]::IsNullOrEmpty($env:SCOOP))) {
        if (Test-Path "$env:SCOOP\shims\gvim.exe") {
            return Test-Path "$env:SCOOP\shims\gvim.exe"
        }
    }
    else {
        ## Look for an installed vim
        @(
            "81",
            "80",
            "74",
            "73"
        ) | ForEach-Object {
            if (Test-Path "C:\Program Files\Vim\vim$_\gvim.exe") {
                return "C:\Program Files\Vim\vim$_\gvim.exe"
            }
            elseif (Test-Path "C:\Program Files (x86)\Vim\vim$_\gvim.exe") {
                return "C:\Program Files (x86)\Vim\vim$_\gvim.exe"
            }
        }
    }

    return ""
}

function Get-DefaultEmacsExe {
    Write-Error "Not implemented yet."
    if (-not ([string]::IsNullOrEmpty($env:SCOOP))) {
        if (Test-Path "$env:SCOOP\shims\emacsclientw.exe") {
            return Test-Path "$env:SCOOP\shims\emacsclientw.exe"
        }
    }
    elseif (Test-Path "C:\Program Files\Emacs\bin\emacsclientw.exe") {
        return "C:\Program Files\Emacs\bin\emacsclientw.exe"
    }
    elseif (Test-Path "C:\Program Files (x86)\Emacs\bin\emacsclientw.exe") {
        return "C:\Program Files (x86)\Emacs\bin\emacsclientw.exe"
    }
    else {
        return ""
    }
}
