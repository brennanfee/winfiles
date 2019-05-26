#!/usr/bin/env pwsh.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Set-StartMenuPin {
    param(
        [string]$appname,
        [switch]$unpin
    )
    try {
        $shellItems = (New-Object -Com Shell.Application).NameSpace(
            'shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items()

        $verbs = ($shellItems | Where-Object { $_.Name -eq $appname }).Verbs()

        $fromMatch = 'From "Start" UnPin|Unpin from Start'
        $toMatch = 'To "Start" Pin|Pin to Start'

        if ($unpin.IsPresent) {
            $verbs | Where-Object { $_.Name.replace('&', '') -match $fromMatch } | `
                ForEach-Object { $_.DoIt() }

            return "App '$appname' unpinned from Start"
        }
        else {
            $verbs | Where-Object { $_.Name.replace('&', '') -match $toMatch } | `
                ForEach-Object { $_.DoIt() }

            return "App '$appname' pinned to Start"
        }
    }
    catch {
        return "Couldn't Pin/Unpin App! (App-Name correct?) -> $appname"
    }
}

function Set-TaskbarPin {
    param(
        [string]$appname,
        [switch]$unpin
    )
    try {
        $shellItems = (New-Object -Com Shell.Application).NameSpace(
            'shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items()

        $verbs = ($shellItems | Where-Object { $_.Name -eq $appname }).Verbs()

        $fromMatch = 'From "Taskbar" UnPin|Unpin from taskbar'
        $toMatch = 'To "Taskbar" Pin|Pin to taskbar'


        if ($unpin.IsPresent) {
            $verbs | Where-Object { $_.Name.replace('&', '') -match $fromMatch } | `
                ForEach-Object { $_.DoIt() }

            return "App '$appname' unpinned from Start"
        }
        else {
            $verbs | Where-Object { $_.Name.replace('&', '') -match $toMatch } | `
                ForEach-Object { $_.DoIt() }

            return "App '$appname' pinned to Start"
        }
    }
    catch {
        return "Couldn't Pin/Unpin App! (App-Name correct?) -> $appname"
    }
}
