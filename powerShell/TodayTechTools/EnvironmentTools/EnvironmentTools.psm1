Set-StrictMode -Version 2.0

# **************** Path Utilities ****************************

function Add-ToPath {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,Position=0)]
        [string]
        $Path,
        [Parameter(Mandatory=$false,Position=1)]
        [switch]
        $Prepend
    )

    $currentPathString = [Microsoft.Win32.Registry]::GetValue("HKEY_CURRENT_USER\Environment","Path", "")

    if (-not [string]::IsNullOrEmpty($currentPathString))
    {
        $currentPath = Get-PathVariable -Name Path -RemoveEmptyPaths -StripQuotes -Target User
    } else {
        $currentPath = New-Object System.Collections.ArrayList
    }

    if (-not ($currentPath -contains $Path))
    {
        if ($Prepend) {
            Add-PathVariable -Value $Path -Name Path -Prepend -Target User
        } else {
            Add-PathVariable -Value $Path -Name Path -Target User
        }
    }
}

function Remove-FromPath {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string]
        $Path
    )

    $currentPathString = [Microsoft.Win32.Registry]::GetValue("HKEY_CURRENT_USER\Environment","Path", "")

    if (-not [string]::IsNullOrEmpty($currentPathString))
    {
        $currentPath = Get-PathVariable -Name Path -RemoveEmptyPaths -StripQuotes -Target User
    } else {
        $currentPath = New-Object System.Collections.ArrayList
    }

    $modifiedPath = $currentPath.Remove($Path)

    Set-PathVariable -Value $modifiedPath -Name Path -Target User
}

# **************** Path Locations ****************************

function Get-SpecialFolder {
  param([System.Environment+SpecialFolder]$Alias)
  [Environment]::GetFolderPath([System.Environment+SpecialFolder]$alias)
}

function Get-DefaultGitPath {
    if (Test-Path "C:\Program Files\Git")
    {
        return "C:\Program Files\Git"
    } elseif (Test-Path "C:\Program Files (x86)\Git")
    {
        return "C:\Program Files (x86)\Git"
    } else
    {
        return ""
    }
}

function Get-DefaultSublimeTextExe {
    if (Test-Path "C:\Program Files\Sublime Text 3\sublime_text.exe")
    {
        return "C:\Program Files\Sublime Text 3\sublime_text.exe"
    }
    elseif (Test-Path "C:\Program Files\Sublime Text 2\sublime_text.exe")
    {
        return "C:\Program Files\Sublime Text 2\sublime_text.exe"
    }
    else
    {
        return ""
    }
}

function Get-DefaultAtomExe {
    if (Test-Path "$env:USERPROFILE\AppData\Local\atom\atom.exe")
    {
        return "$env:USERPROFILE\AppData\Local\atom\atom.exe"
    }
    else
    {
        return ""
    }
}

function Get-DefaultVSCodeExe {
    if (Test-Path "C:\Program Files\Microsoft VS Code\Code.exe")
    {
        return "C:\Program Files\Microsoft VS Code\Code.exe"
    }
    elseif (Test-Path "C:\Program Files (x86)\Microsoft VS Code\Code.exe")
    {
        return "C:\Program Files (x86)\Microsoft VS Code\Code.exe"
    }
    else
    {
        return ""
    }
}

function Get-DefaultVimExe {
    $pathFound = ""
    @(
    "80",
    "74",
    "73"
    ) | ForEach-Object {
        if (Test-Path "C:\Program Files (x86)\Vim\vim$_\gvim.exe")
        {
            $pathFound = "C:\Program Files (x86)\Vim\vim$_\gvim.exe"
        }
        elseif (Test-Path "C:\Program Files\Vim\vim$_\gvim.exe")
        {
            $pathFound = "C:\Program Files\Vim\vim$_\gvim.exe"
        }
    }
    return $pathFound
}

function Get-DefaultVimBatchPath {
    $vimExe = Get-DefaultVimExe
    if ([string]::IsNullOrEmpty($vimExe)) {
        return ""
    }
    $vimFolder = Split-Path $vimExe -Parent
    $vimRootFolder = Split-Path $vimFolder -Parent
    $vimBatchFolder = $vimRootFolder + "\batch\current"
    if (Test-Path $vimBatchFolder) {
        return $vimBatchFolder
    }
    else {
        return ""
    }
}

# **************** WinFilesRoot Environment Variable Management ****************************
# This environment variable is used in various places to set paths to the "portable" location
# of the WinFiles executables.

function Set-WinFilesRoot([switch]$Force) {
    if (($Force) -or (-not $env:WinFilesRoot) -or (-not (Test-Path $env:WinFilesRoot)))
    {
        $modulePath = Split-Path $PSScriptRoot -Parent
        $powerShellPath = Split-Path $modulePath -Parent
        $winFilesPath = Split-Path $powerShellPath -Parent
        [Environment]::SetEnvironmentVariable("WinFilesRoot", $winFilesPath, "User")
        $env:WinFilesRoot = $winFilesPath
        Write-Host -ForegroundColor 'Yellow' "Setting WinFilesRoot environment variable."
    }
    else
    {
        Write-Host -ForegroundColor 'Green' "WinFilesRoot environment variable already set."
    }
}

# **************** Common Location Management ****************************
# These are common locations that I want to be able to jump to with single commands.
# TODO: I wanted to use Push-Location with the Switch methods below, but PowerShell doesn't
# offer an easy way to distinguish between the default stack of the module versus the default
# stack of the shell

function Set-DownloadsLocation {
    [CmdletBinding(DefaultParameterSetName="Path", SupportsShouldProcess=$true)]
    param(
        [Parameter(Position=0,
                   ParameterSetName="Path",
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
    )
    if (-not (Test-Path $Path)) {
        throw "Path given not valid."
    }

    [Environment]::SetEnvironmentVariable("DownloadsPath", $Path, "User")
    $env:DownloadsPath = $Path
}

function Set-ProjectsLocation {
    [CmdletBinding(DefaultParameterSetName="Path", SupportsShouldProcess=$true)]
    param(
        [Parameter(Position=0,
                   ParameterSetName="Path",
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
    )
    if (-not (Test-Path $Path)) {
        throw "Path given not valid."
    }

    [Environment]::SetEnvironmentVariable("ProjectsPath", $Path, "User")
    $env:ProjectsPath = $Path
}

function Set-WorkSourceLocation {
    [CmdletBinding(DefaultParameterSetName="Path", SupportsShouldProcess=$true)]
    param(
        [Parameter(Position=0,
                   ParameterSetName="Path",
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
    )
    if (-not (Test-Path $Path)) {
        throw "Path given not valid."
    }

    [Environment]::SetEnvironmentVariable("WorkSourcePath", $Path, "User")
    $env:WorkSourcePath = $Path
}

function Switch-ToDownloadsLocation {
    if (-not ([string]::IsNullOrEmpty($env:DownloadsPath))) {
        Set-Location $env:DownloadsPath
    } else {
        $defaultLocation = $env:userprofile + "\Downloads"
        if (Test-Path $defaultLocation) {
            Set-Location $defaultLocation
        }
    }
}

function Switch-ToProjectsLocation {
    if (-not ([string]::IsNullOrEmpty($env:ProjectsPath))) {
        Set-Location $env:ProjectsPath
    } else {
        $defaultLocation = "D:\Projects"
        if (Test-Path $defaultLocation) {
            Set-Location $defaultLocation
        } else {
            $defaultLocation = "C:\Projects"
            if (Test-Path $defaultLocation) {
                Set-Location $defaultLocation
            }
        }
    }
}

function Switch-ToWorkSourceLocation {
    if (-not ([string]::IsNullOrEmpty($env:WorkSourcePath))) {
        Set-Location $env:WorkSourcePath
    } else {
        Switch-ToProjectsLocation
    }
}

function Switch-ToWinFilesLocation {
    if (-not ([string]::IsNullOrEmpty($env:WinFilesRoot))) {
        Set-Location $env:WinFilesRoot
    } else {
        $defaultLocation = "D:\WinFiles"
        if (Test-Path $defaultLocation) {
            Set-Location $defaultLocation
        } else {
            $defaultLocation = "C:\WinFiles"
            if (Test-Path $defaultLocation) {
                Set-Location $defaultLocation
            }
        }
    }
}

function Switch-ToProfileLocation {
    if (Test-Path $env:userprofile) {
        Set-Location $env:userprofile
    }
}

function Switch-ToMusicLocation {
    $specialFolder = Get-SpecialFolder "MyMusic"
    if (Test-Path $specialFolder) {
        Set-Location $specialFolder
    }
}

function Switch-ToVideosLocation {
    $specialFolder = Get-SpecialFolder "MyVideos"
    if (Test-Path $specialFolder) {
        Set-Location $specialFolder
    }
}

function Switch-ToPicturesLocation {
    $specialFolder = Get-SpecialFolder "MyPictures"
    if (Test-Path $specialFolder) {
        Set-Location $specialFolder
    }
}

function Switch-ToDocumentsLocation {
    $specialFolder = Get-SpecialFolder "MyDocuments"
    if (Test-Path $specialFolder) {
        Set-Location $specialFolder
    }
}

# **************** Editor Environment Variable Management ****************************

function Set-Editor {
    [CmdletBinding(DefaultParameterSetName="Path", SupportsShouldProcess=$true)]
    param(
        [Parameter(Position=0,
                   ParameterSetName="Path",
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
    )
    if (-not (Test-Path $Path)) {
        throw "File given not valid."
    }

    [Environment]::SetEnvironmentVariable("EDITOR", $Path, "User")
    $env:editor = $Path
    $Pscx:Preferences['TextEditor'] = $env:editor
}

function Set-DefaultEditor {
    # My preferred order of precedence (currently): Vim, Visual Studio Code, Notepad
    if (-not (Set-EditorToVim))
    {
        if (-not (Set-EditorToVSCode))
        {
            Set-EditorToNotepad
        }
    }
}

function Set-EditorToSublime {
    $editor = Get-DefaultSublimeTextExe
    if (-not ([string]::IsNullOrEmpty($editor))) {
        Write-Host -ForegroundColor 'Green' "Setting editor to Sublime Text: $editor"
        Set-Editor($editor)
        return $true
    }
    else {
        Write-Host -ForegroundColor 'Red' "Unable to locate Sublime Text Editor"
        return $false
    }
}

function Set-EditorToVSCode {
    $editor = Get-DefaultVSCodeExe
    if (-not ([string]::IsNullOrEmpty($editor))) {
        Write-Host -ForegroundColor 'Green' "Setting editor to VS Code: $editor"
        Set-Editor($editor)
        return $true
    }
    else {
        Write-Host -ForegroundColor 'Red' "Unable to locate VS Code"
        return $false
    }
}

function Set-EditorToAtom {
    $editor = Get-DefaultAtomExe
    if (-not ([string]::IsNullOrEmpty($editor))) {
        Write-Host -ForegroundColor 'Green' "Setting editor to Atom: $editor"
        Set-Editor($editor)
        return $true
    }
    else {
        Write-Host -ForegroundColor 'Red' "Unable to locate Atom"
        return $false
    }
}

function Set-EditorToVim {
    $editor = Get-DefaultVimExe
    if (-not ([string]::IsNullOrEmpty($editor))) {
        Write-Host -ForegroundColor 'Green' "Setting editor to Vim: $editor"
        Set-Editor($editor)
        return $true
    }
    else {
        Write-Host -ForegroundColor 'Red' "Unable to locate Vim"
        return $false
    }
}

function Set-EditorToNotepad {
    Write-Host -ForegroundColor 'Green' "Setting editor to notepad."
    Set-Editor("C:\Windows\system32\notepad.exe")
    return $true
}

# **************** Git Path Management ****************************
function Add-GitToPath {
    $gitDefaultPath = Get-DefaultGitPath
    $gitCmdPath = "$gitDefaultPath\cmd"
    $gitBinPath = "$gitDefaultPath\bin"
    if (-not ([string]::IsNullOrEmpty($gitCmdPath))) {
        Add-ToPath($gitCmdPath)
        Add-ToPath($gitBinPath)
    }
}

# **************** Vim Utilities & Management ****************************
function Set-VimToGraphical {
    $vimBatchPath =  Get-DefaultVimBatchPath
    $vimBatchParent = Split-Path $vimBatchPath -Parent
    $vimSource = "$vimBatchParent\vim-graphical"

    Copy-Item "$vimSource\*" -Destination $vimBatchPath -Force
}

function Set-VimToTerminal {
    $vimBatchPath =  Get-DefaultVimBatchPath
    $vimBatchParent = Split-Path $vimBatchPath -Parent
    $vimSource = "$vimBatchParent\vim-terminal"

    Copy-Item "$vimSource\*" -Destination $vimBatchPath -Force
}

function Set-VimRuntimePath {
    [CmdletBinding(DefaultParameterSetName="Path", SupportsShouldProcess=$true)]
    param(
        [Parameter(Position=0,
                   ParameterSetName="Path",
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
    )

    [Environment]::SetEnvironmentVariable("VIMRUNTIME", $Path, "User")
    $env:VIMRUNTIME = $Path
}

function Set-VimPath {
    [CmdletBinding(DefaultParameterSetName="Path", SupportsShouldProcess=$true)]
    param(
        [Parameter(Position=0,
                   ParameterSetName="Path",
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
    )

    [Environment]::SetEnvironmentVariable("VIM", $Path, "User")
    $env:VIM = $Path
}

function Set-VimEnvironmentToDefault {
    $vimExe = Get-DefaultVimExe
    $vimExePath = Split-Path $vimExe -Parent
    $vimRootPath = Split-Path $vimExePath -Parent
    Set-VimRuntimePath($vimExePath)
    Set-VimPath($vimRootPath)
}

# **************** Python Utilities & Management ****************************
function Get-SystemPythonPath {
    if ($env:DEFAULT_PYTHON -eq "Python3") {
        return Get-Python3Path
    }
    else {
        return Get-Python2Path
    }
}

function Get-SystemPythonScriptsPath {
    if ($env:DEFAULT_PYTHON -eq "Python3") {
        return Get-Python3ScriptsPath
    }
    else {
        return Get-Python2ScriptsPath
    }
}

function Get-PythonBatchPath {
    return $env:WinFilesRoot + "\Languages\Python"
}

function Get-Python2Path {
    return $env:WinFilesRoot + "\Languages\Python27"
}

function Get-Python2ScriptsPath {
    return $env:WinFilesRoot + "\Languages\Python27\Scripts"
}

function Get-Python3Path {
    return $env:WinFilesRoot + "\Languages\Python34"
}

function Get-Python3ScriptsPath {
    return $env:WinFilesRoot + "\Languages\Python34\Scripts"
}

function Set-SystemPythonTo3 {
    Remove-FromPath(Get-PythonBatchPath)
    Remove-FromPath(Get-Python2ScriptsPath)
    Remove-FromPath(Get-Python2Path)

    Add-ToPath(Get-PythonBatchPath)
    Add-ToPath(Get-Python3Path)
    Add-ToPath(Get-Python3ScriptsPath)

    [Environment]::SetEnvironmentVariable("DEFAULT_PYTHON", "Python3", "User")
    $env:DEFAULT_PYTHON = "Python3"
}

function Set-SystemPythonTo2 {
    Remove-FromPath(Get-PythonBatchPath)
    Remove-FromPath(Get-Python3ScriptsPath)
    Remove-FromPath(Get-Python3Path)

    Add-ToPath(Get-PythonBatchPath)
    Add-ToPath(Get-Python2Path)
    Add-ToPath(Get-Python2ScriptsPath)

    [Environment]::SetEnvironmentVariable("DEFAULT_PYTHON", "Python2", "User")
    $env:DEFAULT_PYTHON = "Python2"
}

# **************** Term (aka Terminal) Environment Variable Management ****************************

function Set-Terminal {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false, Position=0)]
        [string]
        $Terminal = "msys"
    )

    [Environment]::SetEnvironmentVariable("TERM", $Terminal, "User")
    $env:term = $Terminal
}

# **************** DIRCMD (dir sorting and grouping) Environment Variable Management *********

function Set-DirCmd {
    [Environment]::SetEnvironmentVariable("DIRCMD", "/p /o:gn", "User")
    $env:DIRCMD = "/p /o:gn"
}

Export-ModuleMember -Function *
