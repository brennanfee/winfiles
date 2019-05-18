#!/usr/bin/env powershell.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

# Note, these may need to be run BEFORE this script
Set-ExecutionPolicy Unrestricted -scope LocalMachine -Force -ErrorAction Ignore
Set-ExecutionPolicy Unrestricted -scope CurrentUser -Force -ErrorAction Ignore

### Set Profile location (based on how many disks we have)
### 1 disk means porfile is in C:\profile, 2 disks or more means D:\profile

$DriveCount = (Get-PhysicalDisk | Measure-Object).Count

$profilesPath="C:\profile"
if ($DriveCount -ge 2) {
    $profilesPath="D:\profile"
}
$winfilesRoot="$profilesPath\winfiles"

### Setup logging
$logPath="$profilesPath\logs\winfiles"
$logFile="$logPath\bootstrap.log"
if (-not (Test-Path -PathType Container -Path $logPath)) {
    New-Item -ItemType Directory -Force -Path $logPath | Out-Null
}

function Write-Log {
    Param(
        [string]$LogEntry,
        [string]$Color = ""
    )

    $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
    Add-Content $logFile -value "$date : $LogEntry"
    if ([string]::IsNullOrEmpty($Color)) {
        Write-Host $LogEntry
    }
    else {
        Write-Host -ForegroundColor "$Color" $LogEntry
    }
}

Write-Log "Profile script started."

# Check Profile Directory
$profileDirectory = Split-Path $PROFILE -Parent
if(-not (Test-Path($PROFILE))) {
    if (-not (Test-Path $profileDirectory)) {
        New-Item $profileDirectory -ItemType Directory -Force | Out-Null
    }

    New-Item $PROFILE -ItemType File | Out-Null
    Write-Log "Creating profile."
}

$root = $PSScriptRoot

# Set up main PowerShell Profile
$isInstalled = Get-Content $PROFILE | ForEach-Object { if($_.Contains(". $root\powershell-profile\profile.ps1") -eq $true){$true;}}

if($isInstalled -ne $true) {
    Add-Content $PROFILE "#!/usr/bin/env powershell.exe"
    Add-Content $PROFILE "#Requires -Version 5"
    Add-Content $PROFILE ""
    Add-Content $PROFILE ". `"$root\powershell-profile\profile.ps1`""
    Add-Content $PROFILE ""
    Add-Content $PROFILE "function prompt {"
    Add-Content $PROFILE "    return Get-CustomPrompt"
    Add-Content $PROFILE "}"

    Write-Log "Your environment has been configured at: $PROFILE"
}
else {
    Write-Log "Your environment is already configured at: $PROFILE"
}

# Setup NuGet profile used within Visual Studio
# TODO: Originally this was used by Visual Studio, not sure if VS 2017\2019 still uses this or standard
# powershell.  Validate that this is still needed.
$nuGetFile = Join-Path $profileDirectory "NuGet_profile.ps1"
$isNugetInstalled = $false

if (Test-Path $nugetFile) {
    $isNugetInstalled = Get-Content $nuGetFile | ForEach-Object { if($_.Contains(". $root\powershell-profile\profile.ps1") -eq $true){$true;}}
}

if($isNugetInstalled -ne $true) {
    Add-Content $nuGetFile "#!/usr/bin/env powershell.exe"
    Add-Content $nuGetFile "#Requires -Version 5"
    Add-Content $nuGetFile ""
    Add-Content $nuGetFile ". `"$root\powershell-profile\profile.ps1`""
    Add-Content $nuGetFile ""
    Add-Content $nuGetFile "function prompt {"
    Add-Content $nuGetFile "    return Get-CustomPrompt"
    Add-Content $nuGetFile "}"

    Write-Log "Your NuGet environment has been configured at: $nuGetFile"
}
else {
    Write-Log "Your NuGet environment is already configured at: $nuGetFile"
}

Write-Log "Setting up PowerShell repositories"
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

Write-Log "Updating modules"
Update-Module -ErrorAction SilentlyContinue

# Install critical user modules (profile doesn't work without these)
Write-Log "Installing modules"
Install-Module -Name Pscx -AllowClobber -Scope CurrentUser
Install-Module -Name posh-git -AllowClobber -Scope CurrentUser

Write-Log "Profile setup complete" -Color "Green"
Write-Host ""
Write-Log "You will need to close and re-open PowerShell to continue." -Color "Yellow"
Write-Host ""
Write-Log "Complete" -Color "Green"
