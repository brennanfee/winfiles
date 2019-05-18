#!/usr/bin/env powershell.exe
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
        $git = git.exe
    }

    return $git
}

# Invoke Methods

function Invoke-Git {
    $git = Get-GitExeSafe
    "$git" $args
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
        Invoke-Git "add" $args
    }
    else {
        Invoke-Git "add" "."
    }
}

function Invoke-GitCommit {
    Invoke-Git "commit"
}

function Invoke-GitDiff {
    Invoke-Git "diff"
}

function Invoke-GitDiffStaged {
    Invoke-Git "diff" "--cached"
}

function Invoke-GitDifftool {
    Invoke-Git "difftool" "-y"
}

function Invoke-GitDifftoolStaged {
    Invoke-Git "difftool" "-y" "--cached"
}

function Invoke-GitMergetool {
    Invoke-Git "mergetool" "-y"
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
    $result = $git rev-parse --is-inside-work-tree 2>/dev/null

    Write-Host "Result: $result"
}

function Get-GitBranchName {

}

function Get-GitRootPath {
}

function Set-LocationToGitRootPath {
}

function Remove-GitMissingFiles {
}
