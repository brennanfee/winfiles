#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Get-CustomPrompt {
    $realLASTEXITCODE = $LASTEXITCODE

    $isAdminSession = Get-IsAdministrator

    # Set the window title
    #$Host.UI.RawUI.WindowTitle = "{0}{1}" -f $global:AdminSession,$pwd.Path

    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    Write-Host([System.Environment]::NewLine) -nonewline

    if ($isAdminSession) {
        Write-Host("[Admin] ") -nonewline -foregroundcolor Red
    }

    Write-Host("$env:username@$env:computername ") -nonewline -ForegroundColor Green

    Write-Host($(get-location)) -nonewline -ForegroundColor Magenta

    Write-VcsStatus

    $LASTEXITCODE = $realLASTEXITCODE
    return [System.Environment]::NewLine + '> '
}
