#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Configuring privacy and security settings" -ForegroundColor "Green"

# Enable UAC (in case it got disabled)
$key = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
Set-RegistryInt $key "EnableLUA" 1

# Turn off Telemetry (set to Basic)
$key = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
Set-RegistryInt $key "AllowTelemetry" 0  # Off, not even basic (1)
# Sneaky devils keep moving it around
$key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
Set-RegistryInt $key "AllowTelemetry" 0  # Off, not even basic (1)
Set-RegistryInt $key "MaxTelemetryAllowed" 1
Set-RegistryInt $key "DoNotShowFeedbackNotifications" 1
$key = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
Set-RegistryInt $key "AllowTelemetry" 0  # Off, not even basic (1)

# Increase the notification display time, 7 seconds
Set-RegistryInt "HKCU:\Control Panel\Accessibility" "MessageDuration" 7

# Turn off the use of Advertising ID
$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
Set-RegistryInt $key "Enabled" 0
$key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata"
Set-RegistryInt $key "PreventDeviceMetadataFromNetwork" 1

# Bluetooth advertising (seriously?)
$key = "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Bluetooth"
Set-RegistryInt $key "AllowAdvertising" 0

# Do NOT allow apps to send emails
$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\" +
"{9231CB4C-BF57-4AF3-8C55-FDA7BFCC04C5}"
Set-RegistryString $key "Value" "Deny"

# Turn off tailoring experience using diagnostics data
$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy"
Set-RegistryInt $key "TailoredExperiencesWithDiagnosticDataEnabled" 0

# Turn off "Show recommended app suggestions" for Ink Workspace
$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\PenWorkspace"
Set-RegistryInt $key "PenWorkspaceAppSuggestionsEnabled" 0

# Turn off auto downloading of store apps (games and crap)
$key = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore"
Set-RegistryInt $key "AutoDownload" 2

# Disable Internet Explorer ESC protections, this is usually only turned on for servers
$compsPath = "SOFTWARE\Microsoft\Active Setup\Installed Components\" +
"{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"

Set-RegistryInt "HKLM:\$compsPath" "IsInstalled" 0
Set-RegistryInt "HKCU:\$compsPath" "IsInstalled" 0

# For Security, disable the ability for apps on other devices to open messages
# and apps on this device
$key = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP"
Set-RegistryInt $key "RomeSdkChannelUserAuthzPolicy" 0
Set-RegistryInt $key "CdpSessionUserAuthzPolicy" 0
$key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass"
Set-RegistryInt $key "UserAuthPolicy" 0

# Turn off handwriting, ink, and other telemetry
$key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows"
Set-RegistryInt "$key\TabletPC" "PreventHandwritingDataSharing" 1
Set-RegistryInt "$key\HandwritingErrorReports" "PreventHandwritingErrorReports" 1
Set-RegistryInt "$key\AppCompat" "DisableInventory" 1
Set-RegistryInt "$key\AppCompat" "DisableUAR" 1
Set-RegistryInt "$key\AppCompat" "AITEnable" 0
Set-RegistryInt "$key\Personalization" "NoLockScreenCamera" 1
Set-RegistryInt "$key\Messaging" "AllowMessageSync" 0
Set-RegistryInt "$key\CredUI" "DisablePasswordReveal" 1
$key = "HKCU:\Software\Microsoft\InputPersonalization"
Set-RegistryInt $key "RestrictImplicitInkCollection" 1
Set-RegistryInt $key "RestrictImplicitTextCollection" 1
Set-RegistryInt "$key\TrainedDataStore" "HarvestContacts" 0
$key = "HKCU:\Software\Microsoft\Personalization\Settings"
Set-RegistryInt $key "AcceptedPrivacyPolicy" 0
$key = "HKCU:\SOFTWARE\Microsoft\Input\TIPC"
Set-RegistryInt $key "Enabled" 0
$key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\TabletPC"
Set-RegistryInt $key "PreventHandwritingDataSharing" 1
$key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports"
Set-RegistryInt $key "PreventHandwritingErrorReports" 1
$key = "HKLM:\SOFTWARE\WOW6432Node\Policies\Microsoft\Windows\HandwritingErrorReports"
Set-RegistryInt $key "PreventHandwritingErrorReports" 1

# Microsoft Edge, although I never use it
$key = "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge"
Set-RegistryInt "$key\Main" "DoNotTrack" 1
Set-RegistryInt "$key\FlipAhead" "FPEnabled" 0
Set-RegistryInt "$key\Main" "ShowSearchSuggestionsGlobal" 0
Set-RegistryInt "$key\ServiceUI" "EnableCortana" 0
Set-RegistryInt "$key\ServiceUI\ShowSearchHistory" "(Default)" 0 # The default key
Set-RegistryString "$key\Main" "Use FormSuggest" "no"

# IE
$key = "HKCU:\SOFTWARE\Microsoft\Internet Explorer"
Set-RegistryInt "$key\Main" "DoNotTrack" 1

# Content delivery settings, "suggestions" on lock screen, start menu, other
$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
Set-RegistryInt $key "SystemPaneSuggestionsEnabled" 0
Set-RegistryInt $key "RotatingLockScreenEnabled" 0
Set-RegistryInt $key "RotatingLockScreenOverlayEnabled" 0
Set-RegistryInt $key "SilentInstalledAppsEnabled" 0
Remove-ItemProperty -Path "$key\SuggestedApps" -Name * -Force -ErrorAction SilentlyContinue
Set-RegistryInt $key "SoftLandingEnabled" 0
# Turn off "Occasionally Show Suggestions In Start"
Set-RegistryInt $key "SubscribedContent-338388Enabled" 0
# Turn off Suggested Content in Settings app
Set-RegistryInt $key "SubscribedContent-338393Enabled" 0
Set-RegistryInt $key "SubscribedContent-353694Enabled" 0
# Turn off Timeline Suggestions
Set-RegistryInt $key "SubscribedContent-353698Enabled" 0
# Turn off "Get Tips, Tricks, and Suggestions as you use Windows"
Set-RegistryInt $key "SubscribedContent-338389Enabled" 0
# Turn off "Show me Windows welcome experience after updates and occasionally when I sign in..."
Set-RegistryInt $key "SubscribedContent-310093Enabled" 0
# Turn off "My People" Suggestions
Set-RegistryInt $key "SubscribedContent-314563Enabled" 0
# Turn off pre-installed apps
Set-RegistryInt $key "PreInstalledAppsEnabled" 0
Set-RegistryInt $key "PreInstalledAppsEverEnabled" 0
Set-RegistryInt $key "OEMPreInstalledAppsEnabled" 0
Set-RegistryInt $key "ContentDeliveryAllowed" 0
Set-RegistryInt $key "SubscribedContentEnabled" 0

$key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
Set-RegistryInt $key "DisableSoftLanding" 1
#Set-RegistryInt $key "DisableWindowsSpotlightFeatures" 1
Set-RegistryInt $key "DisableWindowsConsumerFeatures" 1

# Biometrics
$key = "HKLM:\SOFTWARE\Policies\Microsoft\Biometrics"
Set-RegistryInt $key "Enabled" 0

# Data access "consent"
$key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore"
Set-RegistryString "$key\userAccountInformation" "Value" "Deny"
Set-RegistryString "$key\contacts" "Value" "Deny"
Set-RegistryString "$key\appointments" "Value" "Deny"
Set-RegistryString "$key\phoneCallHistory" "Value" "Deny"
Set-RegistryString "$key\email" "Value" "Deny"
Set-RegistryString "$key\userDataTasks" "Value" "Deny"
Set-RegistryString "$key\chat" "Value" "Deny"

# OneDrive
$key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive"
Set-RegistryInt $key "DisableFileSyncNGSC" 1
Set-RegistryInt $key "DisableFileSync" 1
$key = "HKLM:\SOFTWARE\Microsoft\OneDrive"
Set-RegistryInt $key "PreventNetworkTrafficPreUserSignIn" 1
$key = "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
Set-RegistryInt $key "System.IsPinnedToNameSpaceTree" 0
$key = "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
Set-RegistryInt $key "System.IsPinnedToNameSpaceTree" 0

# Microsoft Feedback
$key = "HKCU:\Software\Microsoft\Siuf\Rules"
Set-RegistryInt $key "NumberOfSIUFInPeriod" 0
Remove-ItemProperty -Path "$key" -Name "PeriodInNanoSeconds" -Force -ErrorAction SilentlyContinue

# Logging
$key = "HKLM:\System\CurrentControlSet\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener"
Set-RegistryInt $key "Start" 0
$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2297E4E2-5DBE-466D-A12B-0F8286F0D9CA}"
Set-RegistryString $key "Value" "Deny"
$key = "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting"
Set-RegistryInt $key "Disabled" 1

# Maps (who uses Windows or Bing maps?)
$key = "HKLM:\SYSTEM\Maps"
Set-RegistryInt $key "AutoUpdateEnabled" 0

# Telemetry Service
$key = "HKLM:\System\CurrentControlSet\Services\dmwappushservice"
Set-RegistryInt $key "Start" 4

# Disable the SMB1 protocl
Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force

# Disable Remote Assistance
$key = "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance"
Set-RegistryInt $key "fAllowToGetHelp" 0

if (-not ($env:SYSTEMTYPE -eq "WORK")) {
    # Setup Telemetry rule in Firewall
    Write-Host "Adding telemetry ips to firewall"
    $ips = @(
        "134.170.30.202"
        "137.116.81.24"
        "157.56.106.189"
        "184.86.53.99"
        "2.22.61.43"
        "2.22.61.66"
        "204.79.197.200"
        "23.218.212.69"
        "65.39.117.230"
        "65.52.108.33"
        "65.55.108.23"
        "64.4.54.254"
    )

    Remove-NetFirewallRule -DisplayName "Block Telemetry IPs" -ErrorAction SilentlyContinue

    $null = New-NetFirewallRule -DisplayName "Block Telemetry IPs" -Direction Outbound `
        -Action Block -RemoteAddress ([string[]]$ips)

    # Hosts file
    Write-Host "Adding telemetry domains to hosts file"
    $hosts_file = "$env:systemroot\System32\drivers\etc\hosts"
    $domains = @(
        "184-86-53-99.deploy.static.akamaitechnologies.com"
        "a-0001.a-msedge.net"
        "a-0002.a-msedge.net"
        "a-0003.a-msedge.net"
        "a-0004.a-msedge.net"
        "a-0005.a-msedge.net"
        "a-0006.a-msedge.net"
        "a-0007.a-msedge.net"
        "a-0008.a-msedge.net"
        "a-0009.a-msedge.net"
        "a1621.g.akamai.net"
        "a1856.g2.akamai.net"
        "a1961.g.akamai.net"
        "a978.i6g1.akamai.net"
        "a.ads1.msn.com"
        "a.ads2.msads.net"
        "a.ads2.msn.com"
        "ac3.msn.com"
        "ad.doubleclick.net"
        "adnexus.net"
        "adnxs.com"
        "ads1.msads.net"
        "ads1.msn.com"
        "ads.msn.com"
        "aidps.atdmt.com"
        "aka-cdn-ns.adtech.de"
        "a-msedge.net"
        "any.edge.bing.com"
        "a.rad.msn.com"
        "az361816.vo.msecnd.net"
        "az512334.vo.msecnd.net"
        "b.ads1.msn.com"
        "b.ads2.msads.net"
        "bingads.microsoft.com"
        "b.rad.msn.com"
        "bs.serving-sys.com"
        "c.atdmt.com"
        "cdn.atdmt.com"
        "cds26.ams9.msecn.net"
        "choice.microsoft.com"
        "choice.microsoft.com.nsatc.net"
        "compatexchange.cloudapp.net"
        "corpext.msitadfs.glbdns2.microsoft.com"
        "corp.sts.microsoft.com"
        "cs1.wpc.v0cdn.net"
        "db3aqu.atdmt.com"
        "df.telemetry.microsoft.com"
        "diagnostics.support.microsoft.com"
        "e2835.dspb.akamaiedge.net"
        "e7341.g.akamaiedge.net"
        "e7502.ce.akamaiedge.net"
        "e8218.ce.akamaiedge.net"
        "ec.atdmt.com"
        "fe2.update.microsoft.com.akadns.net"
        "feedback.microsoft-hohm.com"
        "feedback.search.microsoft.com"
        "feedback.windows.com"
        "flex.msn.com"
        "g.msn.com"
        "h1.msn.com"
        "h2.msn.com"
        "hostedocsp.globalsign.com"
        "i1.services.social.microsoft.com"
        "i1.services.social.microsoft.com.nsatc.net"
        "ipv6.msftncsi.com"
        "ipv6.msftncsi.com.edgesuite.net"
        "lb1.www.ms.akadns.net"
        "live.rads.msn.com"
        "m.adnxs.com"
        "msedge.net"
        "msftncsi.com"
        "msnbot-65-55-108-23.search.msn.com"
        "msntest.serving-sys.com"
        "oca.telemetry.microsoft.com"
        "oca.telemetry.microsoft.com.nsatc.net"
        "onesettings-db5.metron.live.nsatc.net"
        "pre.footprintpredict.com"
        "preview.msn.com"
        "rad.live.com"
        "rad.msn.com"
        "redir.metaservices.microsoft.com"
        "reports.wes.df.telemetry.microsoft.com"
        "schemas.microsoft.akadns.net"
        "secure.adnxs.com"
        "secure.flashtalking.com"
        "services.wes.df.telemetry.microsoft.com"
        "settings-sandbox.data.microsoft.com"
        "settings-win.data.microsoft.com"
        "sls.update.microsoft.com.akadns.net"
        "sqm.df.telemetry.microsoft.com"
        "sqm.telemetry.microsoft.com"
        "sqm.telemetry.microsoft.com.nsatc.net"
        "ssw.live.com"
        "static.2mdn.net"
        "statsfe1.ws.microsoft.com"
        "statsfe2.update.microsoft.com.akadns.net"
        "statsfe2.ws.microsoft.com"
        "survey.watson.microsoft.com"
        "telecommand.telemetry.microsoft.com"
        "telecommand.telemetry.microsoft.com.nsatc.net"
        "telemetry.appex.bing.net"
        "telemetry.appex.bing.net:443"
        "telemetry.microsoft.com"
        "telemetry.urs.microsoft.com"
        "vortex-bn2.metron.live.com.nsatc.net"
        "vortex-cy2.metron.live.com.nsatc.net"
        "vortex.data.microsoft.com"
        "vortex-sandbox.data.microsoft.com"
        "vortex-win.data.microsoft.com"
        "cy2.vortex.data.microsoft.com.akadns.net"
        "watson.live.com"
        "watson.microsoft.com"
        "watson.ppe.telemetry.microsoft.com"
        "watson.telemetry.microsoft.com"
        "watson.telemetry.microsoft.com.nsatc.net"
        "wes.df.telemetry.microsoft.com"
        "win10.ipv6.microsoft.com"
        "www.bingads.microsoft.com"
        "www.go.microsoft.akadns.net"
        "www.msftncsi.com"

        # extras
        "fe2.update.microsoft.com.akadns.net"
        "s0.2mdn.net"
        "statsfe2.update.microsoft.com.akadns.net",
        "survey.watson.microsoft.com"
        "view.atdmt.com"
        "watson.microsoft.com",
        "watson.ppe.telemetry.microsoft.com"
        "watson.telemetry.microsoft.com",
        "watson.telemetry.microsoft.com.nsatc.net"
        "wes.df.telemetry.microsoft.com"
        "m.hotmail.com"
    )
    Write-Output "" | Out-File -Encoding ASCII -Append $hosts_file
    Write-Output "# Attempt to disable most Telemetry domains for Windows (damn you Microsoft)" | Out-File -Encoding ASCII -Append $hosts_file
    Write-Output "" | Out-File -Encoding ASCII -Append $hosts_file
    foreach ($domain in $domains) {
        if (-Not (Select-String -Path $hosts_file -Pattern $domain)) {
            Write-Output "0.0.0.0 $domain" | Out-File -Encoding ASCII -Append $hosts_file
        }
    }
}

########  Disable unwanted services
# This script disables unwanted Windows services. If you do not want to disable
# certain services comment out the corresponding lines below.

$services = @(
    "diagnosticshub.standardcollector.service" # Microsoft (R) Diagnostics Hub Standard Collector Service
    "DiagTrack"                                # Diagnostics Tracking Service
    "MapsBroker"                               # Downloaded Maps Manager, who uses Bing for maps?
    "RemoteAccess"                             # Routing and Remote Access
    "RemoteRegistry"                           # Remote Registry
    "WMPNetworkSvc"                            # Windows Media Player Network Sharing Service
    "ALG"                                      # Application Layer Gateway Service
    "irmon"                                    # Infrared Monitor Service (for transfering files with IR)
    "SharedAccess"                             # Internet Connection Sharing (ICS), not needed any more
    "iphlpsvc"                                 # IP Helper (old IPv6 helper techs)
    "IpxlatCfgSvc"                             # IP Translation Configuration Service (old IPv6 helper techs)
    "RetailDemo"                               # Retail Demo Service, odd this isn't disabled by default
    "icssvc"                                   # Windows Mobile Hotspot Service, only needed on devices with cellular data
    "WwanSvc"                                  # WWAN AutoConfig, only needed on devices with cellular data
    "HomeGroupListener"
    "HomeGroupProvider"
    "WerSvc"                                   # Error Reporting Service
    "DmwApPushService"                         # WAP Push Service
    "TrkWks"                                   # Distributed Link Tracking Service
)

foreach ($service in $services) {
    Write-Output "Trying to disable $service"
    Get-Service -Name $service -ErrorAction SilentlyContinue | Set-Service -StartupType Disabled
}

# Disable Unneeded Scheduled Tasks
Write-Host "Disabling Unneeded Scheduled Tasks..."
$null = & schtasks.exe /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Disable
$null = & schtasks.exe /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable
$null = & schtasks.exe /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable
$null = & schtasks.exe /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable
$null = & schtasks.exe /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable
$null = & schtasks.exe /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable

# Setup Windows And .NET to use TLS 1.2
Write-Host "Configuring TLS defaults..."

$key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server"
Set-RegistryInt $key "Enabled" 0
Set-RegistryInt $key "DisabledByDefault" 1

$key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client"
Set-RegistryInt $key "Enabled" 0
Set-RegistryInt $key "DisabledByDefault" 1

$key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server"
Set-RegistryInt $key "Enabled" 0
Set-RegistryInt $key "DisabledByDefault" 1

$key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client"
Set-RegistryInt $key "Enabled" 0
Set-RegistryInt $key "DisabledByDefault" 1

$key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server"
Set-RegistryInt $key "Enabled" 1
Set-RegistryInt $key "DisabledByDefault" 0

$key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client"
Set-RegistryInt $key "Enabled" 1
Set-RegistryInt $key "DisabledByDefault" 0

# Now .NET
Set-RegistryInt "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319" "SchUseStrongCrypto" 1
Set-RegistryInt "HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319" "SchUseStrongCrypto" 1

# Now the users profile
$key = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings"
# Should be just TLS 1.2
Set-RegistryInt $key "SecureProtocols" 2048
Set-RegistryInt $key "EnableHttp1_1" 1
Set-RegistryInt $key "EnableHTTP2" 1

Write-Host "Privacy and security settings configured"
Write-Host ""
