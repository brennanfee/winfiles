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

    if ($PSVersionTable.PSEdition -eq "Desktop") {
        $prompt += Write-Prompt "PSHD " -ForegroundColor ([ConsoleColor]::Green)
    }
    else {
        $prompt += Write-Prompt "PSHC " -ForegroundColor ([ConsoleColor]::Green)
    }

    $prompt += Write-Prompt  "$env:username@$env:computername " -ForegroundColor ([ConsoleColor]::Green)

    $prompt += Write-Prompt  "$(get-location) " -ForegroundColor ([ConsoleColor]::Magenta)

    $prompt += Write-VcsStatus

    $prompt += "$([System.Environment]::NewLine)> "

    $LASTEXITCODE = $realLASTEXITCODE
    return $prompt
}
