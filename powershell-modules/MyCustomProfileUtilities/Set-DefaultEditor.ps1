#!/usr/bin/env pwsh.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

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
