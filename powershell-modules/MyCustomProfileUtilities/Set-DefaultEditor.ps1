#!/usr/bin/env pwsh.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Set-DefaultEditor {
    # My preferred order of precedence (currently): Visual Studio Code, Vim, Notepad
    if (-not (Set-EditorToVSCode))
    {
        if (-not (Set-EditorToVim))
        {
            Set-EditorToNotepad | Out-Null
        }
    }
}
