#!/usr/bin/env powershell.exe
#Requires -Version 5

# Run the Setup scripts (a reboot may be needed for the settings to take full
# effect).

Param(
    [Parameter(Position=0)]
    [ValidateSet('home','work')]
    [string] $installType = "home"
)

$scriptsPath = "$PSScriptRoot\scripts"
$outputPath = "$PSScriptRoot\output"

if (!(Test-Path $outputPath))
{
    New-Item $outputPath -ItemType Directory -Force
}

Write-Host "Running Special scripts" -foreground "green"

$special_script = "$scriptsPath\Special\Git-Settings.ps1"
Write-Host "Running script: $special_script"
& "$special_script" -InstallType "$installType" *> "$outputPath\log-special-git-settings.log"

@(
    "Symlinks",
    "Settings",
    "PostSetup"
) | ForEach-Object {
    $directory = $_
    Write-Host "Running $directory scripts" -foreground "green"

    Get-ChildItem "$scriptsPath\$directory" -File -Filter "*.ps1" | Sort-Object "FullName" | ForEach-Object {
        $script = $_.FullName
        Write-Host "Running script: $script"
        & "$script" *> "$outputPath\log-$directory-$_.log"
        Start-Sleep 1
    }
}

rundll32.exe user32.dll, UpdatePerUserSystemParameters

Write-Host "A reboot may be necessary for settings to take effect." -foreground "yellow"
Write-Host "Complete" -foreground "green"
