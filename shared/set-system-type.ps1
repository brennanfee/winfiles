#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -PSEdition Desktop
Set-StrictMode -Version 2.0

# Determine the system type (home or work)
if (-not ($env:SYSTEMTYPE -eq 'HOME' -or $env:SYSTEMTYPE -eq 'WORK')) {
    $choices = '&Home', '&Work'
    $systemType = $Host.UI.PromptForChoice('', 'What type of machine is this?', $choices, 0)
    if ($systemType -eq 1) {
      [Environment]::SetEnvironmentVariable("SYSTEMTYPE", 'WORK', "User")
      $env:SYSTEMTYPE = 'WORK'
    }
    else {
      [Environment]::SetEnvironmentVariable("SYSTEMTYPE", 'HOME', "User")
      $env:SYSTEMTYPE = 'HOME'
    }
}

