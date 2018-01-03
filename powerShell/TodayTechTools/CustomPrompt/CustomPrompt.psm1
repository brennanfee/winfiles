if(!$global:AdminSession) {
   if( ([System.Environment]::OSVersion.Version.Major -gt 5) -and (
         new-object Security.Principal.WindowsPrincipal (
            [Security.Principal.WindowsIdentity]::GetCurrent()) # current user is admin
            ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) )
   {
      $global:AdminSession = '[ADMIN] '
   } else {
      $global:AdminSession = ''
   }
}

function Get-CustomPrompt {
    $realLASTEXITCODE = $LASTEXITCODE

    # Set the window title
    #$Host.UI.RawUI.WindowTitle = "{0}{1}" -f $global:AdminSession,$pwd.Path

    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    Write-Host([System.Environment]::NewLine) -nonewline

    Write-Host($global:AdminSession) -nonewline -foregroundcolor Red

    Write-Host($(get-location)) -nonewline

    Write-VcsStatus

    $LASTEXITCODE = $realLASTEXITCODE
    return [System.Environment]::NewLine + '> '
}

Export-ModuleMember Get-CustomPrompt
