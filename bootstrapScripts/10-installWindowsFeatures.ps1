#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

$computerDetails = Get-ComputerDetails

$delay = 15

########  Install my selection of optional windows features.

# To query installed features:
#   Get-WindowsOptionalFeature -Online | Where-Object {$_.State -eq "Enabled"}
#   | Select-Object FeatureName

# Turn on developer mode, this is done on all machines for the symlink functionality (to not need admin console to create links)
$key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
Set-RegistryInt "$key" "AllowDevelopmentWithoutDevLicense" 1

# First, remove what we don't want
$disableFeature = @(
    "DirectPlay"
    "LegacyComponents"
    "Printing-Foundation-LPDPrintService"
    "Printing-Foundation-LPRPortMonitor"
    "Printing-XPSServices-Features"
    "SMB1Protocol-Client"
    "SMB1Protocol-Deprecation"
    "SMB1Protocol-Server"
    "SMB1Protocol"
    "WindowsMediaPlayer"
    "WorkFolders-Client"
    "Xps-Foundation-Xps-Viewer"
    "Internet-Explorer-Optional-amd64"  # Internet Explorer 11
)

foreach ($feature in $disableFeature) {
    Write-Host ""
    Write-Host "Checking feature: $feature"

    $item = Get-WindowsOptionalFeature -Online -FeatureName $feature
    if ($item -and $item.State -eq "Enabled") {
        Write-Host "Disabling feature: $feature"
        Disable-WindowsOptionalFeature -FeatureName $feature -Online -NoRestart | Out-Null
        Start-Sleep $delay
        Write-Host "Feature disabled: $feature"
    }
    else {
        Write-Host "Feature '$feature' already disabled"
    }
}

# For all desktops (these are installed by default in Windows 10), repeated here to be explicit
$defaultFeatures = @(
    "FaxServicesClientPackage"
    "MediaPlayback"
    "Microsoft-Windows-Client-EmbeddedExp-Package"
    "Microsoft-Windows-NetFx3-OC-Package"
    "Microsoft-Windows-NetFx3-WCF-OC-Package"
    "Microsoft-Windows-NetFx4-US-OC-Package"
    "Microsoft-Windows-NetFx4-WCF-US-OC-Package"
    "MicrosoftWindowsPowerShellV2"
    "MicrosoftWindowsPowerShellV2Root"
    "MSRDC-Infrastructure"
    "NetFx4-AdvSrvs"
    "Printing-Foundation-Features"
    "Printing-Foundation-InternetPrinting-Client"
    "Printing-PrintToPDFServices-Features"
    "SearchEngine-Client-Package"
    "SmbDirect"
    "WCF-Services45"
    "WCF-TCP-PortSharing45"
)

foreach ($feature in $defaultFeatures) {
    Write-Host ""
    Write-Host "Checking default feature: $feature"

    $item = Get-WindowsOptionalFeature -Online -FeatureName $feature
    if ($item -and $item.State -eq "Disabled") {
        Write-Host "Enabling feature: $feature"
        Enable-WindowsOptionalFeature -FeatureName $feature -Online -All -NoRestart | Out-Null
        Start-Sleep $delay
        Write-Host "Feature enabled: $feature"
    }
    else {
        Write-Host "Feature '$feature' is already enabled"
    }
}

# The additional features I want on my machines
$extraFeatures = @(
    "Client-ProjFS"
    "ClientForNFS-Infrastructure"
    "Containers"
    "IIS-HostableWebCore"
    "Microsoft-Windows-Subsystem-Linux"
    "NetFx4Extended-ASPNET45"
    "NFS-Administration"
    "ServicesForNFS-ClientOnly"
    "SimpleTCP"
    "TelnetClient"
    "TFTP"
    "TIFFIFilter"
)

foreach ($feature in $extraFeatures) {
    Write-Host ""
    Write-Host "Checking feature: $feature"

    $item = Get-WindowsOptionalFeature -Online -FeatureName $feature
    if ($item -and $item.State -eq "Disabled") {
        Write-Host "Enabling feature: $feature"
        Enable-WindowsOptionalFeature -FeatureName $feature -Online -All -NoRestart | Out-Null
        Start-Sleep $delay
        Write-Host "Feature enabled: $feature"
    }
    else {
        Write-Host "Feature '$feature' is already enabled"
    }
}

# Virtualization (only when not in a VM already)
if (-not ($computerDetails.IsVirtual)) {
    $virtualizationFeatures = @(
        "Containers-DisposableClientVM" # a.k.a. Windows Sandbox
        "HypervisorPlatform"
        "Microsoft-Hyper-V-All"
        "Microsoft-Hyper-V-Hypervisor"
        "Microsoft-Hyper-V-Management-Clients"
        "Microsoft-Hyper-V-Management-PowerShell"
        "Microsoft-Hyper-V-Services"
        "Microsoft-Hyper-V-Tools-All"
        "Microsoft-Hyper-V"
        "VirtualMachinePlatform"
    )

    foreach ($feature in $virtualizationFeatures) {
        Write-Host ""
        Write-Host "Checking Virtualization feature: $feature"

        $item = Get-WindowsOptionalFeature -Online -FeatureName $feature
        if ($item -and $item.State -eq "Disabled") {
            Write-Host "Enabling feature: $feature"
            Enable-WindowsOptionalFeature -FeatureName $feature -Online -All -NoRestart | Out-Null
            Start-Sleep $delay
            Write-Host "Feature enabled: $feature"
        }
        else {
            Write-Host "Feature '$feature' is already enabled"
        }
    }
}

$disableCapabilities = @(
    "Media.WindowsMediaPlayer~"
    "XPS.Viewer~"
)

foreach ($feature in $disableCapabilities) {
    Write-Host ""
    Write-Host "Checking feature: $feature"

    $items = Get-WindowsCapability -Online |
        Where-Object { $_.State -eq "Installed" } |
        Where-Object { $_.Name.StartsWith($feature) }

    if ($items) {
        foreach ($item in $items) {
            $name = $item.Name
            Write-Host "Disabling feature: $name"
            Remove-WindowsCapability -Online -Name $name | Out-Null
            Start-Sleep $delay
            Write-Host "Feature disabled: $name"
        }
    }
    else {
        Write-Host "Feature '$feature' already disabled"
    }
}

$extraCapabilities = @(
    "OpenSSH.Client~"
    "OpenSSH.Server~"
    "Tools.DeveloperMode.Core~"
)

foreach ($feature in $extraCapabilities) {
    Write-Host ""
    Write-Host "Checking feature: $feature"

    $items = Get-WindowsCapability -Online |
    Where-Object { $_.State -eq "NotPresent" } |
    Where-Object { $_.Name.StartsWith($feature) }

    if ($items) {
        foreach ($item in $items) {
            $name = $item.Name
            Write-Host "Enabling feature: $name"
            Add-WindowsCapability -Online -Name $name | Out-Null
            Start-Sleep $delay
            Write-Host "Feature enabled: $name"
        }
    }
    else {
        Write-Host "Feature '$feature' already enabled"
    }
}

