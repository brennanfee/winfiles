#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Configuring Windows Features and Capabilities" -ForegroundColor "Green"

$computerDetails = Get-ComputerDetails

$delay = 20

## TODO: Add functions to my system modules for enabling/disabling features and capabilities

########  Install my selection of optional windows features.

# To query installed features:
#   Get-WindowsOptionalFeature -Online | Where-Object {$_.State -eq "Enabled"}
#   | Select-Object FeatureName

# For all desktops (these are installed by default in Windows 10), repeated here to be explicit
$defaultFeatures = @(
    #"Internet-Explorer-Optional-amd64"  # Removed below
    "MediaPlayback"
    "MicrosoftWindowsPowerShellV2"
    "MicrosoftWindowsPowerShellV2Root"
    "MSRDC-Infrastructure"
    "NetFx4-AdvSrvs"
    "Printing-Foundation-Features"
    "Printing-Foundation-InternetPrinting-Client"
    "Printing-PrintToPDFServices-Features"
    #"Printing-XPSServices-Features" # Removed below
    "SearchEngine-Client-Package"
    "SmbDirect"
    "WCF-Services45"
    "WCF-TCP-PortSharing45"
    # "WindowsMediaPlayer" # Removed below
    # "WorkFolders-Client" # Removed below
)

foreach ($feature in $defaultFeatures) {
    Write-Host ""
    Write-Host "Checking default feature: $feature"

    $item = Get-WindowsOptionalFeature -Online -FeatureName $feature
    if ($item -and $item.State -eq "Disabled") {
        Write-Host "Enabling feature: $feature"
        $null = Enable-WindowsOptionalFeature -FeatureName $feature -Online -All -NoRestart
        Start-Sleep $delay
        Write-Host "Feature enabled: $feature"
    }
    else {
        Write-Host "Feature '$feature' is already enabled"
    }
}

# Now, remove what we don't want
$disableFeature = @(
    "DirectPlay"
    "Internet-Explorer-Optional-amd64"  # Internet Explorer 11
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
)

foreach ($feature in $disableFeature) {
    Write-Host ""
    Write-Host "Checking feature: $feature"

    $item = Get-WindowsOptionalFeature -Online -FeatureName $feature
    if ($item -and $item.State -eq "Enabled") {
        Write-Host "Disabling feature: $feature"
        $null = Disable-WindowsOptionalFeature -FeatureName $feature -Online -NoRestart
        Start-Sleep $delay
        Write-Host "Feature disabled: $feature"
    }
    else {
        Write-Host "Feature '$feature' already disabled"
    }
}

# The additional features I want on my machines
$extraFeatures = @(
    "Client-ProjFS"
    "ClientForNFS-Infrastructure"
    "Containers"
    "IIS-ASPNET45"
    "IIS-DefaultDocument"
    "IIS-HostableWebCore"
    "IIS-HttpCompressionDynamic"
    "IIS-HttpCompressionStatic"
    "IIS-HttpErrors"
    "IIS-HttpLogging"
    "IIS-HttpRedirect"
    "IIS-NetFxExtensibility45"
    "IIS-StaticContent"
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
        $null = Enable-WindowsOptionalFeature -FeatureName $feature -Online -All -NoRestart
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
            $null = Enable-WindowsOptionalFeature -FeatureName $feature -Online -All -NoRestart
            Start-Sleep $delay
            Write-Host "Feature enabled: $feature"
        }
        else {
            Write-Host "Feature '$feature' is already enabled"
        }
    }
}

# Disable unwanted capabilities
$disableCapabilities = @(
    "Browser.InternetExplorer~"
    "Media.WindowsMediaPlayer~"
    "Microsoft.Windows.MSPaint~"
    "Microsoft.Windows.PowerShell.ISE~"
    "Microsoft.Windows.WordPad~"
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
            $null = Remove-WindowsCapability -Online -Name $name
            Start-Sleep $delay
            Write-Host "Feature disabled: $name"
        }
    }
    else {
        Write-Host "Feature '$feature' already disabled"
    }
}

Write-Host "Windows Features and Capabilities configured."
Write-Host ""
