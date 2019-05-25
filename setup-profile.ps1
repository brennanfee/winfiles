#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

# Note, these may need to be run BEFORE this script
Set-ExecutionPolicy Unrestricted -scope LocalMachine -Force -ErrorAction Ignore
Set-ExecutionPolicy Unrestricted -scope CurrentUser -Force -ErrorAction Ignore

$winfilesRoot = $PSScriptRoot

Write-Host "Setting up PowerShell repositories"
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

Write-Host "Updating modules"
Update-Module -ErrorAction SilentlyContinue
# Only the minimum necessary modules to make the profile work
Install-Module -Name Pscx -AllowClobber -Scope CurrentUser -Force
Install-Module -Name posh-git -AllowClobber -Scope CurrentUser -AllowPrerelease -Force

if (-not ("$env:PSModulePath".Contains("$winfilesRoot\powershell-modules"))) {
    $env:PSModulePath = "$winfilesRoot\powershell-modules;" + "$env:PSModulePath"
}

Write-Host "Importing modules"
Import-Module SystemUtilities
Import-Module MyCustomProfileUtilities

# Setup the profile environment variable
Set-MyCustomProfileLocation

$logFile = "$env:ProfilePath\logs\winfiles\bootstrap-pull.log"
Write-Log $logFile "----------"
Write-LogAndConsole $logFile "Profile script started."

$outputContent = @"
#!/usr/bin/env pwsh.exe
#Requires -Version 5

. `"$winfilesRoot\powershell-profile\profile.ps1`"

function prompt {
    return Get-CustomPrompt
}
"@

# Set up main PowerShell Profile
$profileContent = ""
if (Test-Path $PROFILE) {
    $profileContent = Get-Content -Path $PROFILE | Out-String
}

if (-not ($profileContent.Contains("$winfilesRoot\powershell-profile\profile.ps1"))) {
    Set-Content $PROFILE $outputContent
    Write-LogAndConsole $logFile "Your environment has been configured at: $PROFILE"
}
else {
    Write-LogAndConsole $logFile "Your environment is already configured at: $PROFILE"
}

# Setup NuGet profile used within Visual Studio
# TODO: Originally this was used by Visual Studio, not sure if VS 2017\2019 still uses this or standard
# powershell.  Validate that this is still needed.
$profileDirectory = Split-Path $PROFILE -Parent
$nugetFile = Join-Path $profileDirectory "NuGet_profile.ps1"
$nugetContent = ""
if (Test-Path $nugetFile) {
    $nugetContent = Get-Content -Path $nugetFile | Out-String
}

if (-not ($nugetContent.Contains("$winfilesRoot\powershell-profile\profile.ps1"))) {
    Set-Content $nugetFile $outputContent
    Write-LogAndConsole $logFile "Your NuGet environment has been configured at: $nugetFile"
}
else {
    Write-LogAndConsole $logFile "Your NuGet environment is already configured at: $nugetFile"
}

# Check if scoop is already installed
if (-not (Test-Path "$env:ProfilePath\scoop\shims\scoop")) {
    Write-Log "Scoop missing, preparing for install"
    [environment]::SetEnvironmentVariable('SCOOP', "$env:ProfilePath\scoop", 'User')
    $env:SCOOP = "$env:ProfilePath\scoop"
    [environment]::SetEnvironmentVariable('SCOOP_GLOBAL', 'C:\scoop-global', 'Machine')
    $env:SCOOP_GLOBAL = 'C:\scoop-global'

    # Install scoop
    Invoke-Expression ((Invoke-WebRequest -Uri 'https://get.scoop.sh').Content)

    Write-Log "Scoop installed." -Color "Green"
}
else {
    Write-Log "Scoop already installed." -Color "Green"
}

# Check if git is already installed
if (-not (Test-Path "$env:SCOOP_GLOBAL\shims\git.exe")) {
    Write-Log "Git missing, preparing for install using scoop."

    Invoke-Expression "scoop install sudo 7zip git which --global"
    [environment]::SetEnvironmentVariable('GIT_SSH', (resolve-path (scoop which ssh)), 'USER')
    Write-Log "Git installed." -Color "Green"
}
else {
    Write-Log "Git already installed." -Color "Green"
}

Write-LogAndConsole $logFile "Profile setup complete" -Color "Green"
Write-Host ""
Write-LogAndConsole $logFile "You will need to close and re-open PowerShell to continue." -Color "Yellow"
Write-Host ""
Write-LogAndConsole $logFile "Complete" -Color "Green"
