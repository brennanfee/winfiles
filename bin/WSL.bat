@echo off
rem Start mintty terminal for WSL package  in current directory
%LOCALAPPDATA%\wsltty\bin\mintty.exe -i "%LOCALAPPDATA%\wsltty\wsl.ico" --WSL= --configdir="%APPDATA%\wsltty" tmux
