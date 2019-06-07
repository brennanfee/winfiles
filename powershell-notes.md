# Powershell Notes

## Other package "providers"

- GitHubProvider -> git repo as a package\module
- GitLabProvider -> same as above but for GitLab
- ChocolateyGet -> how does this differ than the chocolatey one
- DockerProvider
- GistProvider
- AppxGet ?

## PowerShell Modules (from PSGallery)

- powershell-yaml
- PSLogging

- JumpCloud
- Posh-SSH
- AWSPowerShell
- AWSPowerShell.NetCore
- JiraPS
- ACMESharp
- MSI
- BurntToast
- PsIni
- SSHSessions
- Logging
- PowerShellForGitHub
- Get-ChildItemColor -> fallback for wsl ls?
- windows-screenfetch
- Posh-ACME
- BetterCredentials
- SemVer
- OpenSSHUtils

## Sample Scripts for Manual Installations

### Install Uplay (ubisoft)

``` PowerShell
$url = "http://ubi.li/4vxt9"
$output = "C:\Users\$env:username\Desktop\Programs\UPlay.exe"
Invoke-WebRequest $url -OutFile $output
Start-Process -FilePath "C:\Users\$env:username\Desktop\Programs\UPlay.exe" -ArgumentList "/S /silent /s" 2>&1 | Out-Null
```

### Install FireFox Nightly

``` PowerShell
$url = "https://download.mozilla.org/?product=firefox-nightly-latest-ssl&os=win64&lang=en-US"
$output = "C:\Users\$env:username\Desktop\Programs\FireFoxNightly.exe"
Invoke-WebRequest $url -OutFile $output
Start-Process -FilePath "C:\Users\$env:username\Desktop\Programs\FireFoxNightly.exe" -ArgumentList "/S /silent /s -ms" 2>&1 | Out-Null
```

### Install PushBullet

``` PowerShell
$url = "https://update.pushbullet.com/pushbullet_installer.exe"
$output = "C:\Users\$env:username\Desktop\Programs\PushBullet.exe"
Invoke-WebRequest $url -OutFile $output
Start-Process -FilePath "C:\Users\$env:username\Desktop\Programs\PushBullet.exe" -ArgumentList "/S /silent /s" 2>&1 | Out-Null
```
