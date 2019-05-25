#!/usr/bin/env pwsh.exe

function Pin-App
{
    param(
        [string]$appname,
        [switch]$unpin
    )
    try
    {
        if ($unpin.IsPresent)
        {
            ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'From "Start" UnPin|Unpin from Start'} | %{$_.DoIt()}
            return "App '$appname' unpinned from Start"
        }
        else
        {
            ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'To "Start" Pin|Pin to Start'} | %{$_.DoIt()}
            return "App '$appname' pinned to Start"
        }
    }
    catch
    {
        Write-Error "Error Pinning/Unpinning App! (App-Name correct?) -> $appname"
    }
}

Pin-App "Store" -unpin
Pin-App "Microsoft Store" -unpin
Pin-App "Microsoft Edge" -unpin
Pin-App "Skype" -unpin
Pin-App "Paint" -unpin
Pin-App "Paint 3D" -unpin
Pin-App "Mail" -unpin
Pin-App "Photos" -unpin
Pin-App "Facebook" -unpin
Pin-App "Xbox" -unpin

Pin-App "Windows PowerShell" -pin
Pin-App "Command Prompt" -pin
Pin-App "Control Panel" -pin
Pin-App "Calculator" -pin
Pin-App "Calendar" -pin
