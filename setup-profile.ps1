#!/usr/bin/env powershell.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

$winfilesRoot = $PSScriptRoot

Write-Host "Setting up PowerShell repositories"
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

Write-Host "Updating modules"
Update-Module -ErrorAction SilentlyContinue
Update-Module -Name Pscx -AllowClobber -Scope CurrentUser
Update-Module -Name posh-git -AllowClobber -Scope CurrentUser

if (-not ("$env:PSModulePath".Contains("$winfilesRoot\powershell-modules"))) {
    $env:PSModulePath = "$winfilesRoot\powershell-modules;" + "$env:PSModulePath"
}

Write-Host "Importing modules"
Import-Module SystemUtilities
Import-Module MyCustomProfileUtilities

# Setup the profile environment variable
Set-MyCustomProfileLocation
#Set-HomeEnvironmentVariable  # move to bootstrap

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

# Set up main PowerShell Profile
$isInstalled = Get-Content "$PROFILE" | ForEach-Object { if($_.Contains(". $winfilesRoot\powershell-profile\profile.ps1") -eq $true){$true;}}

if ($isInstalled -ne $true) {
    Add-Content $PROFILE "#!/usr/bin/env powershell.exe"
    Add-Content $PROFILE "#Requires -Version 5"
    Add-Content $PROFILE ""
    Add-Content $PROFILE ". `"$winfilesRoot\powershell-profile\profile.ps1`""
    Add-Content $PROFILE ""
    Add-Content $PROFILE "function prompt {"
    Add-Content $PROFILE "    return Get-CustomPrompt"
    Add-Content $PROFILE "}"

    Write-LogAndConsole $logFile "Your environment has been configured at: $PROFILE"
}
else {
    Write-LogAndConsole $logFile "Your environment is already configured at: $PROFILE"
}

# Setup NuGet profile used within Visual Studio
# TODO: Originally this was used by Visual Studio, not sure if VS 2017\2019 still uses this or standard
# powershell.  Validate that this is still needed.
$nuGetFile = Join-Path $profileDirectory "NuGet_profile.ps1"
$isNugetInstalled = $false

if (Test-Path "$nugetFile") {
    $isNugetInstalled = Get-Content "$nuGetFile" | ForEach-Object { if($_.Contains(". $winfilesRoot\powershell-profile\profile.ps1") -eq $true){$true;}}
}

if($isNugetInstalled -ne $true) {
    Add-Content $nuGetFile "#!/usr/bin/env powershell.exe"
    Add-Content $nuGetFile "#Requires -Version 5"
    Add-Content $nuGetFile ""
    Add-Content $nuGetFile ". `"$winfilesRoot\powershell-profile\profile.ps1`""
    Add-Content $nuGetFile ""
    Add-Content $nuGetFile "function prompt {"
    Add-Content $nuGetFile "    return Get-CustomPrompt"
    Add-Content $nuGetFile "}"

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
