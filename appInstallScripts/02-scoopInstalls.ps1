#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Installing Scoop applications - global"
$apps = @(
    [PSCustomObject]@{Name = "dark"; Path = "$env:SCOOP_GLOBAL\shims\dark.exe" }
    [PSCustomObject]@{Name = "innounp"; Path = "$env:SCOOP_GLOBAL\shims\innounp.exe" }
    [PSCustomObject]@{Name = "sudo"; Path = "$env:SCOOP_GLOBAL\shims\sudo.cmd" }
)

foreach ($app in $apps) {
    Install-WithScoop $app.Name $app.Path -Global
}

Write-Host "Installing Scoop applications - main"
$apps = @(
    [PSCustomObject]@{Name = "cake"; Path = "$env:SCOOP\shims\cake.exe" }
    [PSCustomObject]@{Name = "concfg"; Path = "$env:SCOOP\shims\concfg.cmd" }
    [PSCustomObject]@{Name = "ffsend"; Path = "$env:SCOOP\shims\ffsend.exe" }
    [PSCustomObject]@{Name = "file"; Path = "$env:SCOOP\shims\file.exe" }
    [PSCustomObject]@{Name = "gcc"; Path = "$env:SCOOP\shims\gcc.exe" }
    [PSCustomObject]@{Name = "gdb"; Path = "$env:SCOOP\shims\gdb.exe" }
    [PSCustomObject]@{Name = "genact"; Path = "$env:SCOOP\shims\genact.exe" }
    [PSCustomObject]@{Name = "neofetch"; Path = "$env:SCOOP\shims\neofetch.exe" }
    [PSCustomObject]@{Name = "shasum"; Path = "$env:SCOOP\shims\shasum.exe" }
    [PSCustomObject]@{Name = "shfmt"; Path = "$env:SCOOP\shims\shfmt.exe" }
    [PSCustomObject]@{Name = "tar"; Path = "$env:SCOOP\shims\tar.exe" }
    [PSCustomObject]@{Name = "tldr"; Path = "$env:SCOOP\shims\tldr.exe" }
    [PSCustomObject]@{Name = "touch"; Path = "$env:SCOOP\shims\touch.exe" }
)

foreach ($app in $apps) {
    Install-WithScoop $app.Name $app.Path
}

Write-Host "Installing Scoop applications - extras"
$apps = @(
    [PSCustomObject]@{Name = "task"; Path = "$env:SCOOP\shims\task.exe" }
)

foreach ($app in $apps) {
    Install-WithScoop $app.Name $app.Path
}

Write-Host "Installing Scoop applications - fonts"
$apps = @(
    [PSCustomObject]@{Name = "Arimo-NF"; Path = "$env:SystemRoot\Fonts\Arimo*Nerd*.ttf" }
    [PSCustomObject]@{Name = "CascadiaCode-NF"; Path = "$env:SystemRoot\Fonts\Caskaydia*Nerd*.ttf" }
    [PSCustomObject]@{Name = "Cousine-NF"; Path = "$env:SystemRoot\Fonts\Cousine*Nerd*.ttf" }
    [PSCustomObject]@{Name = "FiraCode-NF"; Path = "$env:SystemRoot\Fonts\Fura Code*Nerd*.otf" }
    [PSCustomObject]@{Name = "FiraMono-NF"; Path = "$env:SystemRoot\Fonts\Fura Mono*Nerd*.otf" }
    [PSCustomObject]@{Name = "Hack-NF"; Path = "$env:SystemRoot\Fonts\Hack Regular*Nerd*.ttf" }
    [PSCustomObject]@{Name = "Hasklig-NF"; Path = "$env:SystemRoot\Fonts\Hasklug*Nerd*.otf" }
    [PSCustomObject]@{Name = "JetBrainsMono-NF"; Path = "$env:SystemRoot\Fonts\JetBrains*Nerd*.ttf" }
    [PSCustomObject]@{Name = "Noto-NF"; Path = "$env:SystemRoot\Fonts\Noto Sans*Nerd*.ttf" }
    [PSCustomObject]@{Name = "SourceCodePro-NF"; Path = "$env:SystemRoot\Fonts\Sauce Code Pro*Nerd*.ttf" }
    [PSCustomObject]@{Name = "Tinos-NF"; Path = "$env:SystemRoot\Fonts\Tinos*Nerd*.ttf" }
    [PSCustomObject]@{Name = "Ubuntu-NF"; Path = "$env:SystemRoot\Fonts\Ubuntu Medium*Nerd*.ttf" }
    [PSCustomObject]@{Name = "UbuntuMono-NF"; Path = "$env:SystemRoot\Fonts\Ubuntu Mono*Nerd*.ttf" }
    [PSCustomObject]@{Name = "VictorMono-NF"; Path = "$env:SystemRoot\Fonts\Victor Mono*Nerd*.ttf" }
    # These are not from NerdFonts but part of Microsofts new terminal
    [PSCustomObject]@{Name = "Cascadia-Code"; Path = "$env:SystemRoot\Fonts\Cascadia.ttf" }
    [PSCustomObject]@{Name = "Cascadia-Mono"; Path = "$env:SystemRoot\Fonts\CascadiaMono.ttf" }
    # Other fonts
    [PSCustomObject]@{Name = "FiraCode"; Path = "$env:SystemRoot\Fonts\FiraCode-Regular.ttf" }
    [PSCustomObject]@{Name = "JetBrains-Mono"; Path = "$env:SystemRoot\Fonts\JetBrainsMono-Bold.ttf" }
)

foreach ($app in $apps) {
    Install-WithScoop $app.Name $app.Path
}
