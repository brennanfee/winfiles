#Credit: http://www.nivot.org/post/2009/08/15/PowerShell20PersistingCommandHistory.aspx
# save last 100 history items on exit
$historyPath = Join-Path (split-path $profile) history.clixml

# hook powershell's exiting event & hide the registration with -supportevent.
Register-EngineEvent -SourceIdentifier powershell.exiting -SupportEvent -Action {
    Get-History -Count 1000 | Export-Clixml (Join-Path (split-path $profile) history.clixml) }

# load previous history, if it exists
if ((Test-Path $historyPath)) {
    $count = 0
    Import-Clixml $historyPath | Where-Object {$count++;$true} | Add-History
    Write-Host -Fore Green "`nLoaded $count history item(s).`n"
}
