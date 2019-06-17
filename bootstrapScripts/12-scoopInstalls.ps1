#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Installing Scoop applications - global"
$apps = @(
    [PSCustomObject]@{Name = "7zip"; Path = "$env:SCOOP_GLOBAL\shims\7z.exe" }
    [PSCustomObject]@{Name = "dark"; Path = "$env:SCOOP_GLOBAL\shims\dark.exe" }
    [PSCustomObject]@{Name = "git"; Path = "$env:SCOOP_GLOBAL\shims\git.exe" }
    [PSCustomObject]@{Name = "git-lfs"; Path = "$env:SCOOP_GLOBAL\shims\git-lfs.exe" }
    [PSCustomObject]@{Name = "innounp"; Path = "$env:SCOOP_GLOBAL\shims\innounp.exe" }
    [PSCustomObject]@{Name = "sudo"; Path = "$env:SCOOP_GLOBAL\shims\sudo.cmd" }
    [PSCustomObject]@{Name = "which"; Path = "$env:SCOOP_GLOBAL\shims\which.exe" }
    [PSCustomObject]@{Name = "aria2"; Path = "$env:SCOOP_GLOBAL\shims\aria2c.exe" }
    [PSCustomObject]@{Name = "pwsh"; Path = "$env:SCOOP_GLOBAL\shims\aria2c.exe" }
)

foreach ($app in $apps) {
    Install-WithScoop $app.Name $app.Path -Global
}

Write-Host "Installing Scoop applications - main"
$apps = @(
    [PSCustomObject]@{Name = "aws"; Path = "$env:SCOOP\shims\aws.exe" }
    [PSCustomObject]@{Name = "cake"; Path = "$env:SCOOP\shims\cake.exe" }
    [PSCustomObject]@{Name = "cloc"; Path = "$env:SCOOP\shims\cloc.exe" }
    [PSCustomObject]@{Name = "ColorTool"; Path = "$env:SCOOP\shims\colortool.exe" }
    [PSCustomObject]@{Name = "concfg"; Path = "$env:SCOOP\shims\concfg.cmd" }
    [PSCustomObject]@{Name = "coreutils"; Path = "$env:SCOOP\shims\md5sum.exe" }
    [PSCustomObject]@{Name = "ctags"; Path = "$env:SCOOP\shims\ctags.exe" }
    [PSCustomObject]@{Name = "curl"; Path = "$env:SCOOP\shims\curl.exe" }
    [PSCustomObject]@{Name = "diffutils"; Path = "$env:SCOOP\shims\diff.exe" }
    [PSCustomObject]@{Name = "dig"; Path = "$env:SCOOP\shims\dig.exe" }
    [PSCustomObject]@{Name = "dos2unix"; Path = "$env:SCOOP\shims\dos2unix.exe" }
    [PSCustomObject]@{Name = "editorconfig"; Path = "$env:SCOOP\shims\editorconfig.exe" }
    [PSCustomObject]@{Name = "fd"; Path = "$env:SCOOP\shims\fd.exe" }
    [PSCustomObject]@{Name = "ffmpeg"; Path = "$env:SCOOP\shims\ffmpeg.exe" }
    [PSCustomObject]@{Name = "ffsend"; Path = "$env:SCOOP\shims\ffsend.exe" }
    [PSCustomObject]@{Name = "file"; Path = "$env:SCOOP\shims\file.exe" }
    [PSCustomObject]@{Name = "findutils"; Path = "$env:SCOOP\shims\find.exe" }
    [PSCustomObject]@{Name = "gawk"; Path = "$env:SCOOP\shims\gawk.exe" }
    [PSCustomObject]@{Name = "gcc"; Path = "$env:SCOOP\shims\gcc.exe" }
    [PSCustomObject]@{Name = "gdb"; Path = "$env:SCOOP\shims\gdb.exe" }
    [PSCustomObject]@{Name = "genact"; Path = "$env:SCOOP\shims\genact.exe" }
    [PSCustomObject]@{Name = "gnupg"; Path = "$env:SCOOP\apps\gnupg\current\bin\gpg.exe" }
    [PSCustomObject]@{Name = "go"; Path = "$env:SCOOP\shims\go.exe" }
    [PSCustomObject]@{Name = "grep"; Path = "$env:SCOOP\shims\grep.exe" }
    [PSCustomObject]@{Name = "gzip"; Path = "$env:SCOOP\shims\gzip.exe" }
    [PSCustomObject]@{Name = "handbrake-cli"; Path = "$env:SCOOP\shims\handbrakecli.exe" }
    [PSCustomObject]@{Name = "hub"; Path = "$env:SCOOP\shims\hub.exe" }
    [PSCustomObject]@{Name = "imagemagick"; Path = "$env:SCOOP\shims\magick.exe" }
    [PSCustomObject]@{Name = "jira"; Path = "$env:SCOOP\shims\jira.exe" }
    [PSCustomObject]@{Name = "jq"; Path = "$env:SCOOP\shims\jq.exe" }
    [PSCustomObject]@{Name = "latex"; Path = "$env:SCOOP\shims\jq.exe" }
    [PSCustomObject]@{Name = "less"; Path = "$env:SCOOP\shims\less.exe" }
    [PSCustomObject]@{Name = "megatools"; Path = "$env:SCOOP\shims\megacopy.exe" }
    [PSCustomObject]@{Name = "neofetch"; Path = "$env:SCOOP\shims\neofetch.exe" }
    [PSCustomObject]@{Name = "neovim"; Path = "$env:SCOOP\shims\nvim.exe" }
    [PSCustomObject]@{Name = "nodejs-lts"; Path = "$env:SCOOP\shims\node.exe" }
    [PSCustomObject]@{Name = "nssm"; Path = "$env:SCOOP\shims\nssm.exe" }
    [PSCustomObject]@{Name = "patch"; Path = "$env:SCOOP\shims\patch.exe" }
    [PSCustomObject]@{Name = "perl"; Path = "$env:SCOOP\apps\perl\current\perl\bin\perl.exe" }
    [PSCustomObject]@{Name = "python"; Path = "$env:SCOOP\shims\python.exe" }
    [PSCustomObject]@{Name = "ripgrep"; Path = "$env:SCOOP\shims\rg.exe" }
    [PSCustomObject]@{Name = "ruby"; Path = "$env:SCOOP\apps\ruby\current\bin\ruby.exe" }
    [PSCustomObject]@{Name = "rustup"; Path = "$env:SCOOP\persist\rustup\.cargo\bin\rustc.exe" }
    [PSCustomObject]@{Name = "sed"; Path = "$env:SCOOP\shims\sed.exe" }
    [PSCustomObject]@{Name = "serve"; Path = "$env:SCOOP\shims\serve.exe" }
    [PSCustomObject]@{Name = "shasum"; Path = "$env:SCOOP\shims\shasum.exe" }
    [PSCustomObject]@{Name = "shellcheck"; Path = "$env:SCOOP\shims\shellcheck.exe" }
    [PSCustomObject]@{Name = "shfmt"; Path = "$env:SCOOP\shims\shfmt.exe" }
    [PSCustomObject]@{Name = "tar"; Path = "$env:SCOOP\shims\tar.exe" }
    [PSCustomObject]@{Name = "terraform"; Path = "$env:SCOOP\shims\terraform.exe" }
    [PSCustomObject]@{Name = "tldr"; Path = "$env:SCOOP\shims\tldr.exe" }
    [PSCustomObject]@{Name = "touch"; Path = "$env:SCOOP\shims\touch.exe" }
    #   [PSCustomObject]@{Name = "transmission-cli"; Path = "$env:SCOOP\shims\transmission-create.exe" } # not for work machines
    [PSCustomObject]@{Name = "unzip"; Path = "$env:SCOOP\shims\unzip.exe" }
    [PSCustomObject]@{Name = "vim"; Path = "$env:SCOOP\shims\vim.exe" }
    [PSCustomObject]@{Name = "wget"; Path = "$env:SCOOP\shims\wget.exe" }
    [PSCustomObject]@{Name = "youtube-dl"; Path = "$env:SCOOP\shims\youtube-dl.exe" }
    [PSCustomObject]@{Name = "zip"; Path = "$env:SCOOP\shims\zip.exe" }
)

foreach ($app in $apps) {
    Install-WithScoop $app.Name $app.Path
}

Write-Host "Installing Scoop applications - extras"
$apps = @(
    [PSCustomObject]@{Name = "alacritty"; Path = "$env:SCOOP\shims\blah.exe" }
    [PSCustomObject]@{Name = "bitwarden-cli"; Path = "$env:SCOOP\shims\blah.exe" }
    [PSCustomObject]@{Name = "carnac"; Path = "$env:SCOOP\shims\blah.exe" }
    [PSCustomObject]@{Name = "etcher-cli"; Path = "$env:SCOOP\shims\blah.exe" }
    [PSCustomObject]@{Name = "emacs"; Path = "$env:SCOOP\shims\blah.exe" }
    #[PSCustomObject]@{Name = "hack-font"; Path = "$env:SystemRoot\Fonts\Hack-Regular.exe" }
    [PSCustomObject]@{Name = "pandoc"; Path = "$env:SCOOP\shims\blah.exe" }
    [PSCustomObject]@{Name = "rufus"; Path = "$env:SCOOP\shims\blah.exe" }
    [PSCustomObject]@{Name = "speedcrunch"; Path = "$env:SCOOP\shims\blah.exe" }
    [PSCustomObject]@{Name = "sysinternals"; Path = "$env:SCOOP\shims\psinfo.exe" }
    [PSCustomObject]@{Name = "task"; Path = "$env:SCOOP\shims\blah.exe" }
    [PSCustomObject]@{Name = "texmaker"; Path = "$env:SCOOP\shims\blah.exe" }
)

foreach ($app in $apps) {
    Install-WithScoop $app.Name $app.Path
}

Write-Host "Installing Scoop applications - java"
$apps = @(
    [PSCustomObject]@{Name = "corretto8"; Path = "$env:SCOOP\shims\blah.exe" }
    [PSCustomObject]@{Name = "corretto11"; Path = "$env:SCOOP\shims\blah.exe" }
)

foreach ($app in $apps) {
    Install-WithScoop $app.Name $app.Path
}

Write-Host "Installing Scoop applications - fonts"
$apps = @(
    [PSCustomObject]@{Name = "Arimo-NF"; Path = "$env:SystemRoot\Fonts\Arimo*Nerd*.ttf" }
    [PSCustomObject]@{Name = "Cousine-NF"; Path = "$env:SystemRoot\Fonts\Cousine*Nerd*.ttf" }
    [PSCustomObject]@{Name = "DejaVuSansMono-NF"; Path = "$env:SystemRoot\Fonts\DejaVu Sans Mono*Nerd*.ttf" }
    [PSCustomObject]@{Name = "DroidSansMono-NF"; Path = "$env:SystemRoot\Fonts\Droid Sans Mono*Nerd*.otf" }
    [PSCustomObject]@{Name = "FiraCode-NF"; Path = "$env:SystemRoot\Fonts\Fura Code*Nerd*.otf" }
    [PSCustomObject]@{Name = "FiraMono-NF"; Path = "$env:SystemRoot\Fonts\Fura Mono*Nerd*.otf" }
    [PSCustomObject]@{Name = "Go-Mono-NF"; Path = "$env:SystemRoot\Fonts\Go Mono*Nerd*.ttf" }
    [PSCustomObject]@{Name = "Hack-NF"; Path = "$env:SystemRoot\Fonts\Hack Regular*Nerd*.ttf" }
    [PSCustomObject]@{Name = "Hasklig-NF"; Path = "$env:SystemRoot\Fonts\Hasklug*Nerd*.otf" }
    [PSCustomObject]@{Name = "LiberationMono-NF"; Path = "$env:SystemRoot\Fonts\Literation Mono*Nerd*.ttf" }
    [PSCustomObject]@{Name = "Monoid-NF"; Path = "$env:SystemRoot\Fonts\Monoid*Nerd*.ttf" }
    [PSCustomObject]@{Name = "Noto-NF"; Path = "$env:SystemRoot\Fonts\Noto Sans*Nerd*.ttf" }
    [PSCustomObject]@{Name = "RobotoMono-NF"; Path = "$env:SystemRoot\Fonts\Roboto Mono*Nerd*.ttf" }
    [PSCustomObject]@{Name = "SourceCodePro-NF"; Path = "$env:SystemRoot\Fonts\Sauce Code Pro*Nerd*.ttf" }
    [PSCustomObject]@{Name = "Tinos-NF"; Path = "$env:SystemRoot\Fonts\Tinos*Nerd*.ttf" }
    [PSCustomObject]@{Name = "Ubuntu-NF"; Path = "$env:SystemRoot\Fonts\Ubuntu Medium*Nerd*.ttf" }
    [PSCustomObject]@{Name = "UbuntuMono-NF"; Path = "$env:SystemRoot\Fonts\Ubuntu Mono*Nerd*.ttf" }
)

foreach ($app in $apps) {
    Install-WithScoop $app.Name $app.Path
}

$computerDetails = Get-ComputerDetails

if (-not ($computerDetails.IsVirtual)) {
    Write-Host "Installing Scoop applications - virtualization"
    $apps = @(
        [PSCustomObject]@{Name = "packer"; Path = "$env:SCOOP\shims\packer.exe" }
        [PSCustomObject]@{Name = "chefdk"; Path = "$env:SCOOP\shims\blah.exe" }
    )

    foreach ($app in $apps) {
        Install-WithScoop $app.Name $app.Path
    }
}

## Additional apps, install as needed
##
## darktable (extras) -> raw photo tool
## uget (extras) -> download manager, win and linux
