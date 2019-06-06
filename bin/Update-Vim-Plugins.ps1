#!/usr/bin/env pwsh.exe

if (Get-Command "gvim.exe") {
    gvim.exe -N -u "$env:USERPROFILE\.vim\vimrc.bundles" +PackUpdate +PackClean +qa -
}
