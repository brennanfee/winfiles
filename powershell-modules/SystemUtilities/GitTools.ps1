#!/usr/bin/env pwsh.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Get-GitExe {
    # Look for lab first (gitlab version of hub)
    $app = Get-ApplicationPath "lab.exe"
    if (-not ([string]::IsNullOrEmpty($app))) {
        return $app
    }

    # Look for hub second
    $app = Get-ApplicationPath "hub.exe"
    if (-not ([string]::IsNullOrEmpty($app))) {
        return $app
    }

    # Lastly, git itself
    $app = Get-ApplicationPath "git.exe"
    if (-not ([string]::IsNullOrEmpty($app))) {
        return $app
    }
    else {
        return ""
    }
}

function Get-GitExeSafe {
    $git = Get-GitExe
    if ([string]::IsNullOrEmpty($git)) {
        $git = "git.exe"
    }

    return $git
}

# Invoke Methods

function Invoke-Git {
    $git = Get-GitExeSafe
    Invoke-Expression -command "&$git $args"
}

function Invoke-GitStatus {
    Invoke-Git "status"
}

function Invoke-GitStatusSb {
    Invoke-Git "status" "-sb"
}

function Invoke-GitPush {
    Invoke-Git "push" "--tags"
}

function Invoke-GitPull {
    Invoke-Git "pull"
}

function Invoke-GitFetch {
    Invoke-Git "fetch" "--all" "--tags"
}

function Invoke-GitAdd {
    if ($args) {
        Invoke-Git "add" "$args"
    }
    else {
        Invoke-Git "add" "."
    }
}

function Invoke-GitCommit {
    Invoke-Git "commit"
}

function Invoke-GitDiff {
    if ($args) {
        Invoke-Git "diff" "$args"
    }
    else {
        Invoke-Git "diff"
    }
}

function Invoke-GitDiffStaged {
    if ($args) {
        Invoke-Git "diff" "--cached" "$args"
    }
    else {
        Invoke-Git "diff" "--cached"
    }
}

function Invoke-GitDifftool {
    if ($args) {
        Invoke-Git "difftool" "-y" "$args"
    }
    else {
        Invoke-Git "difftool" "-y"
    }
}

function Invoke-GitDifftoolStaged {
    if ($args) {
        Invoke-Git "difftool" "-y" "--cached" "$args"
    }
    else {
        Invoke-Git "difftool" "-y" "--cached"
    }
}

function Invoke-GitMergetool {
    if ($args) {
        Invoke-Git "mergetool" "-y" "$args"
    }
    else {
        Invoke-Git "mergetool" "-y"
    }
}

function Invoke-GitExport {
    Invoke-Git "archive" "--format zip" "--output"
}

function Invoke-GitLog {
    Invoke-Git "log" "--graph" "--pretty=oneline" "--abbrev-commit"
}

# Tools

function Get-GitInARepo {
    $git = Get-GitExeSafe
    $command = "&$git rev-parse --is-inside-work-tree" + ' 2>$null'
    $result = Invoke-Expression -command $command
    if ($result -eq "true") {
        return $true
    }
    else {
        return $false
    }
}

function Get-GitBranchName {
    if (Get-GitInARepo) {
        $git = Get-GitExeSafe
        $result = Invoke-Expression -command "&$git rev-parse --abbrev-ref HEAD"
        return $result
    }
    else {
        Write-Host "Not a git repo."
        return ""
    }
}

function Get-GitRootPath {
    if (Get-GitInARepo) {
        $git = Get-GitExeSafe
        $result = Invoke-Expression -command "&$git rev-parse --show-toplevel"
        return $result
    }
    else {
        return (Get-Location).Path
    }
}

function Set-LocationToGitRootPath {
    param(
        [string]$Subfolder = ""
    )

    $path = Get-GitRootPath
    if ([string]::IsNullOrEmpty($Subfolder)) {
        Set-Location $path
    }
    else {
        $newPath = Join-Path $path $Subfolder
        if (Test-Path $newPath) {
            Set-Location $newPath
        }
        else {
            Set-Location $path
        }
    }
}

function Invoke-GitStageRemovedFiles {
    Write-Error "Not Implemented Yet."
}
