#!/usr/bin/env pwsh.exe

function Pin-TaskbarApp
{
    param(
        [string]$appname,
        [switch]$unpin
    )
    try
    {
        if ($unpin.IsPresent)
        {
            ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'From "Taskbar" UnPin|Unpin from taskbar'} | %{$_.DoIt()}
            return "App '$appname' unpinned from Start"
        }
        else
        {
            ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'To "Taskbar" Pin|Pin to taskbar'} | %{$_.DoIt()}
            return "App '$appname' pinned to Start"
        }
    }
    catch
    {
        Write-Error "Error Pinning/Unpinning App! (App-Name correct?) -> $appname"
    }
}

Pin-TaskbarApp "Store" -unpin
Pin-TaskbarApp "Microsoft Store" -unpin
Pin-TaskbarApp "Mail" -unpin

Pin-TaskbarApp "Windows PowerShell" -pin
