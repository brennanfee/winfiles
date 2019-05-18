#!/usr/bin/env powershell.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

Set-Alias g Invoke-Git
Set-Alias git Invoke-Git
Set-Alias get Invoke-Git

Set-Alias gs Invoke-GitStatus
Set-Alias gss Invoke-GitStatusSb

Set-Alias gpu Invoke-GitPush
Set-Alias gpl Invoke-GitPull
Set-Alias gf Invoke-GitFetch
Set-Alias ga Invoke-GitAdd
Set-Alias gc Invoke-GitCommit
Set-Alias gd Invoke-GitDiff
Set-Alias gds Invoke-GitDiffStaged
Set-Alias gdt Invoke-GitDifftool
Set-Alias gdts Invoke-GitDifftoolStaged
Set-Alias gmt Invoke-GitMergetool

Set-Alias gexp Invoke-GitExport

Set-Alias gl Invoke-GitLog

Set-Alias cdr Set-LocationToGitRootPath
