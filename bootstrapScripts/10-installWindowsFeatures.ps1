#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Configuring Windows Features and Capabilities" -ForegroundColor "Green"

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

    $items = Get-WindowsOptionalFeature -Online -FeatureName $feature
    foreach ($item in $items) {
        $name = $item.FeatureName
        if ($item -and $item.State -eq "Disabled") {
            Write-Host "Enabling feature: $name"
            $null = Enable-WindowsOptionalFeature -FeatureName $name -Online -All -NoRestart
            Start-Sleep $delay
            Write-Host "Feature enabled: $name"
        }
        else {
            Write-Host "Feature '$name' is already enabled"
        }
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
    "TFTP"
    "WindowsMediaPlayer"
    "WorkFolders-Client"
    "NetFx4Extended-ASPNET45"
    "Windows-Identity-Foundation"
    # All SMB1 features
    "SMB1*"
    # Everything IIS
    "IIS-*"
    # Everything WCF
    "WCF-*"
    # Everything WAS (Windows Activation Service)
    "WAS-*"
    # Everything MSMQ
    "MSMQ-*"
)

foreach ($feature in $disableFeature) {
    Write-Host ""
    Write-Host "Checking feature: $feature"

    $items = Get-WindowsOptionalFeature -Online -FeatureName $feature
    foreach ($item in $items) {
        $name = $item.FeatureName
        if ($item -and $item.State -eq "Enabled") {
            Write-Host "Disabling feature: $name"
            $null = Disable-WindowsOptionalFeature -FeatureName $name -Online -NoRestart
            Start-Sleep $delay
            Write-Host "Feature disabled: $name"
        }
        else {
            Write-Host "Feature '$name' already disabled"
        }
    }
}

# The additional features I want on my machines
$extraFeatures = @(
    "Client-ProjFS"
    "ClientForNFS-Infrastructure"
    "Containers"
    "NFS-Administration"
    "ServicesForNFS-ClientOnly"
    "SimpleTCP"
    "TelnetClient"
    "TIFFIFilter"
    # Virtualization Stuff
    "Containers-DisposableClientVM" # a.k.a. Windows Sandbox
    "HypervisorPlatform"
    "Microsoft-Hyper-V"
    "Microsoft-Hyper-V-*"
    "VirtualMachinePlatform"
    "TestBlah"
)

foreach ($feature in $extraFeatures) {
    Write-Host ""
    Write-Host "Checking feature: $feature"

    $items = Get-WindowsOptionalFeature -Online -FeatureName $feature
    foreach ($item in $items) {
        $name = $item.FeatureName
        if ($item -and $item.State -eq "Disabled") {
            Write-Host "Enabling feature: $name"
            $null = Enable-WindowsOptionalFeature -FeatureName $name -Online -All -NoRestart
            Start-Sleep $delay
            Write-Host "Feature enabled: $name"
        }
        else {
            Write-Host "Feature '$name' is already enabled"
        }
    }
}

# Virtualization (only when not in a VM already)
#$computerDetails = Get-ComputerDetails
# if (-not ($computerDetails.IsVirtual)) {
#     $virtualizationFeatures = @(
#     )

#     foreach ($feature in $virtualizationFeatures) {
#         Write-Host ""
#         Write-Host "Checking Virtualization feature: $feature"

#         $items = Get-WindowsOptionalFeature -Online -FeatureName $feature
#         foreach ($item in $items) {
#             $name = $item.FeatureName
#             if ($item -and $item.State -eq "Disabled") {
#                 Write-Host "Enabling feature: $name"
#                 $null = Enable-WindowsOptionalFeature -FeatureName $name -Online -All -NoRestart
#                 Start-Sleep $delay
#                 Write-Host "Feature enabled: $name"
#             }
#             else {
#                 Write-Host "Feature '$name' is already enabled"
#             }
#         }
#     }
# }

# Disable unwanted capabilities
$disableCapabilities = @(
    "App.StepsRecorder~"
    "Browser.InternetExplorer~"
    "Media.WindowsMediaPlayer~"
    "Microsoft.Windows.MSPaint~"
    "Microsoft.Windows.PowerShell.ISE~"
    "Microsoft.Windows.WordPad~"
    "OneCoreUAP.OneSync~"
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
