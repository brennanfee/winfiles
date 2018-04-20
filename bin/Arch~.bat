@echo off
rem Start mintty terminal for WSL package  in current directory
%LOCALAPPDATA%\wsltty\bin\mintty.exe -i "%USERPROFILE%\winFiles\bin\Arch.ico" --WSL="Arch" --configdir="%APPDATA%\wsltty" -~ tmux
