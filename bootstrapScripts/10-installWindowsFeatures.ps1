#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

$computerDetails = Get-ComputerDetails

########  Install my selection of optional windows features.

# To query installed features:
#   Get-WindowsOptionalFeature -Online | Where-Object {$_.State -eq "Enabled"}
#   | Select-Object FeatureName

# Turn on developer mode, this is done on all machines for the symlink functionality (to not need admin console to create links)
$key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
Set-RegistryInt "$key" "AllowDevelopmentWithoutDevLicense" 1

# First, remove what we don't want
Disable-WindowsOptionalFeature -FeatureName WindowsMediaPlayer -Online -NoRestart
Disable-WindowsOptionalFeature -FeatureName Printing-XPSServices-Features -Online -NoRestart

# For all desktops (these are installed by default in Windows 10), repeated here to be explicit
Enable-WindowsOptionalFeature -FeatureName FaxServicesClientPackage -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName Internet-Explorer-Optional-amd64 -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName MediaPlayback -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName Microsoft-Windows-Client-EmbeddedExp-Package -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName Microsoft-Windows-NetFx3-OC-Package -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName Microsoft-Windows-NetFx3-WCF-OC-Package -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName Microsoft-Windows-NetFx4-US-OC-Package -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName Microsoft-Windows-NetFx4-WCF-US-OC-Package -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName MicrosoftWindowsPowerShellV2 -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName MicrosoftWindowsPowerShellV2Root -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName MSRDC-Infrastructure -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName NetFx4-AdvSrvs -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName Printing-Foundation-Features -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName Printing-Foundation-InternetPrinting-Client -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName Printing-PrintToPDFServices-Features -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName SearchEngine-Client-Package -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName SmbDirect -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName WCF-Services45 -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName WCF-TCP-PortSharing45 -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName WorkFolders-Client -Online -All -LimitAccess -NoRestart

# The additional features I want on my machines
Enable-WindowsOptionalFeature -FeatureName Client-ProjFS -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName ClientForNFS-Infrastructure -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName Containers -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName IIS-HostableWebCore -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName Microsoft-Windows-Subsystem-Linux -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName NFS-Administration -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName ServicesForNFS-ClientOnly -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName SimpleTCP -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName TelnetClient -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName TFTP -Online -All -LimitAccess -NoRestart
Enable-WindowsOptionalFeature -FeatureName TIFFIFilter -Online -All -LimitAccess -NoRestart

# Virtualization (only when not in a VM already)
if (-not ($computerDetails.IsVirtual)) {
    Enable-WindowsOptionalFeature -FeatureName VirtualMachinePlatform -Online -All -LimitAccess -NoRestart
}


# Enable-WindowsOptionalFeature -FeatureName SMB1Protocol -Online -All -LimitAccess -NoRestart
# Enable-WindowsOptionalFeature -FeatureName SMB1Protocol-Client -Online -All -LimitAccess -NoRestart
# Enable-WindowsOptionalFeature -FeatureName SMB1Protocol-Deprecation -Online -All -LimitAccess -NoRestart
# Enable-WindowsOptionalFeature -FeatureName Windows-Defender-Default-Definitions -Online -All -LimitAccess -NoRestart
# Enable-WindowsOptionalFeature -FeatureName Xps-Foundation-Xps-Viewer -Online -All -LimitAccess -NoRestart

# In the new "Add feature" dialog
# Graphics Tools
# Microsoft WebDriver
# MSIX Packaging Tool Driver
# OpenSSH Server
# RAS Connection Manager Administration Kit (CMAK)
# RIP Listener
# RSAT: Active Directory Certificate Services Tools
# RSAT: Active Directory Domain Services and Lightweight Directory Services Tools
# RSAT: BitLocker Drive Encryption Administration Utilities
# RSAT: Data Center Bridging LLDP Tools
# RSAT: DHCP Server Tools
# RSAT: DNS Server Tools
# RSAT: Failover Clustering Tools
# RSAT: File Services Tools
# RSAT: Group Policy Management Tools
# RSAT: IP Address Management (IPAM) Client
# RSAT: Network Controller Management Tools
# RSAT: Network Load Balancing Tools
# RSAT: Remote Access Management Tools
# RSAT: Remote Desktop Services Tools
# RSAT: Server Manager
# RSAT: Shielded VM Tools
# RSAT: Storage Migration Service Management Tools
# RSAT: Storage Replica Module for Windows PowerShell
# RSAT: System Insights Module for Windows PowerShell
# RSAT: Volume Activation Tools
# RSAT: Windows Server Update Services Tools
# Simple Network Management Protocol (SNMP)
# Windows Storage Management
# WMI SNMP Provider
# XPS Viewer



# # For all desktops ("Standard") machines
# Enable-WindowsOptionalFeature -FeatureName NetFx4Extended-ASPNET45 -Online -All -LimitAccess -NoRestart
# Enable-WindowsOptionalFeature -FeatureName RasRip -Online -All -LimitAccess -NoRestart

# # Extras for "dev" desktops
# if ($Configuration -eq 'Developer') {
#     Enable-WindowsOptionalFeature -FeatureName IIS-ApplicationDevelopment -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-ApplicationInit -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-ASPNET45 -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-CommonHttpFeatures -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-CustomLogging -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-DefaultDocument -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-DirectoryBrowsing -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-HealthAndDiagnostics -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-HttpCompressionDynamic -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-HttpCompressionStatic -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-HttpErrors -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-HttpLogging -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-HttpRedirect -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-HttpTracing -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-IPSecurity -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-ISAPIExtensions -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-ISAPIFilter -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-LoggingLibraries -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-ManagementConsole -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-ManagementScriptingTools -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-ManagementService -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-NetFxExtensibility45 -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-Performance -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-RequestFiltering -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-RequestMonitor -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-Security -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-StaticContent -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-WebServer -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-WebServerManagementTools -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-WebServerRole -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-WebSockets -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName IIS-WindowsAuthentication -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName WAS-ConfigurationAPI -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName WAS-ProcessModel -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName WAS-WindowsActivationService -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName WCF-HTTP-Activation45 -Online -All -LimitAccess -NoRestart
#     Enable-WindowsOptionalFeature -FeatureName WCF-TCP-Activation45 -Online -All -LimitAccess -NoRestart
# }

