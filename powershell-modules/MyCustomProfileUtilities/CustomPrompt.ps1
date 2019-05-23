#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Get-CustomPrompt {
    # This version of my prompt requires posh-git 1.0-beta3 or later
    $realLASTEXITCODE = $LASTEXITCODE

    $prompt = "$([System.Environment]::NewLine)"

    if (Get-IsAdministrator) {
        $prompt += Write-Prompt  "[Admin] " -ForegroundColor ([ConsoleColor]::Red)
    }

    $prompt += Write-Prompt  "$env:username@$env:computername " -ForegroundColor ([ConsoleColor]::Green)

    $prompt += Write-Prompt  "$(get-location) " -ForegroundColor ([ConsoleColor]::Magenta)

    $prompt += Write-VcsStatus

    if ($PSVersionTable.PSEdition -eq "Desktop") {
        $prompt += Write-Prompt " (PS DESKTOP)" -ForegroundColor ([ConsoleColor]::Blue)
    }
    else {
        $prompt += Write-Prompt " (PS CORE)" -ForegroundColor ([ConsoleColor]::Blue)
    }

    $prompt += "$([System.Environment]::NewLine)> "

    $LASTEXITCODE = $realLASTEXITCODE
    return $prompt
}
