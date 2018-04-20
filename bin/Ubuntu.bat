@echo off
rem Start mintty terminal for WSL package  in current directory
%LOCALAPPDATA%\wsltty\bin\mintty.exe -i "%PROGRAMFILES%/WindowsApps/CanonicalGroupLimited.UbuntuonWindows_1604.2017.922.0_x64__79rhkp1fndgsc/images/icon.ico" --WSL="Ubuntu" --configdir="%APPDATA%\wsltty" tmux
