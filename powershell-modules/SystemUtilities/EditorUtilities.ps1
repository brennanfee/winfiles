#!/usr/bin/env pwsh.exe
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

    [Environment]::SetEnvironmentVariable("EDITOR", "$Path", "User")
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

function Get-ApplicationPath {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [string]
        $Application
    )

    $command = Get-Command -CommandType Application -ErrorAction Ignore -Name "$Application"
    if ($command) {
        if (Test-Path $command.Source) {
            return $command.Source
        }
    }

    return ""
}

function Get-DefaultSublimeTextExe {
    $app = Get-ApplicationPath "sublime_text.exe"
    if (-not ([string]::IsNullOrEmpty($app))) {
        return $app
    }
    elseif (Test-Path "C:\Program Files\Sublime Text 3\sublime_text.exe") {
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
    $app = Get-ApplicationPath "atom.exe"
    if (-not ([string]::IsNullOrEmpty($app))) {
        return $app
    }
    elseif (Test-Path "$env:LOCALAPPDATA\atom\atom.exe") {
        return "$env:LOCALAPPDATA\atom\atom.exe"
    }
    else {
        return ""
    }
}

function Get-DefaultVSCodeExe {
    $app = Get-ApplicationPath "code"
    if (-not ([string]::IsNullOrEmpty($app))) {
        return $app
    }
    elseif (Test-Path "$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin\code") {
        return "$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin\code"
    }
    elseif (Test-Path "C:\Program Files\Microsoft VS Code\bin\code") {
        return "C:\Program Files\Microsoft VS Code\bin\code"
    }
    elseif (Test-Path "C:\Program Files (x86)\Microsoft VS Code\bin\code") {
        return "C:\Program Files (x86)\Microsoft VS Code\bin\code"
    }
    else {
        return ""
    }
}

function Get-DefaultVimExe {
    $app = Get-ApplicationPath "gvim.exe"
    if (-not ([string]::IsNullOrEmpty($app))) {
        return $app
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
    $app = Get-ApplicationPath "emacsclientw.exe"
    if (-not ([string]::IsNullOrEmpty($app))) {
        return $app
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
