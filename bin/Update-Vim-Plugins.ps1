#!/usr/bin/env pwsh.exe

& "C:\Program Files (x86)\vim\vim80\gvim.exe" -N -u "$env:userprofile\.vimrc.bundles" +PlugInstall +PlugClean! +qa -
