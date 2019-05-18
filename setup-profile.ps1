#!/usr/bin/env powershell.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

$winfilesRoot = $PSScriptRoot

Write-Host "Setting up PowerShell repositories"
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

Write-Host "Updating modules"
Update-Module -ErrorAction SilentlyContinue
Install-Module -Name Pscx -AllowClobber -Scope CurrentUser
Install-Module -Name posh-git -AllowClobber -Scope CurrentUser

if (-not ("$env:PSModulePath".Contains("$winfilesRoot\powershell-modules"))) {
    $env:PSModulePath = "$winfilesRoot\powershell-modules;" + "$env:PSModulePath"
}

Write-Host "Importing modules"
Import-Module SystemUtilities
Import-Module MyCustomProfileUtilities

# Setup the profile environment variable
Set-MyCustomProfileLocation

$logFile="$env:ProfilePath\logs\winfiles\bootstrap-pull.log"
Write-LogAndConsole $logFile "Profile script started."

# Check Profile Directory
$profileDirectory = Split-Path $PROFILE -Parent
if(-not (Test-Path "$PROFILE")) {
    if (-not (Test-Path "$profileDirectory")) {
        New-Item "$profileDirectory" -ItemType Directory -Force | Out-Null
    }

    New-Item "$PROFILE" -ItemType File | Out-Null
    Write-LogAndConsole $logFile "Creating profile."
}
else {
    Write-LogAndConsole $logFile "Profile already exists."
}

$outputContent = @"
#!/usr/bin/env powershell.exe
#Requires -Version 5

. `"$winfilesRoot\powershell-profile\profile.ps1`"

function prompt {
    return Get-CustomPrompt
}
"@

# Set up main PowerShell Profile
$profileContent = Get-Content -Path $PROFILE | Out-String
if (-not ($profileContent.Contains("$winfilesRoot\powershell-profile\profile.ps1"))) {
    Add-Content $PROFILE $outputContent
    Write-LogAndConsole $logFile "Your environment has been configured at: $PROFILE"
}
else {
    Write-LogAndConsole $logFile "Your environment is already configured at: $PROFILE"
}

# Setup NuGet profile used within Visual Studio
# TODO: Originally this was used by Visual Studio, not sure if VS 2017\2019 still uses this or standard
# powershell.  Validate that this is still needed.
$nuGetFile = Join-Path $profileDirectory "NuGet_profile.ps1"
$nugetContent = ""
if (Test-Path "$nugetFile") {
    $nugetContent = Get-Content -Path $nugetFile | Out-String
}

if (-not ($nugetContent.Contains("$winfilesRoot\powershell-profile\profile.ps1"))) {
    Add-Content $nuGetFile $outputContent
    Write-LogAndConsole $logFile "Your NuGet environment has been configured at: $nuGetFile"
}
else {
    Write-LogAndConsole $logFile "Your NuGet environment is already configured at: $nuGetFile"
}

Write-LogAndConsole $logFile "Profile setup complete" -Color "Green"
Write-Host ""
Write-LogAndConsole $logFile "You will need to close and re-open PowerShell to continue." -Color "Yellow"
Write-Host ""
Write-LogAndConsole $logFile "Complete" -Color "Green"
