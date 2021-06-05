# Notes for transition to WinGet

## Tasks

1. Write PowerShell script to install WinGet if not already there.

## Features

Install options, --override to pass in arguments to the underlying installer.

C:\Users\vagrant\AppData\Local\Microsoft\WindowsApps\winget.exe

Add-AppxPackage -Path "C:\Path\to\File.Appx"

https://docs.microsoft.com/en-us/powershell/module/appx/add-appxpackage?view=windowsserver2019-ps

## Package analysis

### Critical one's to create or wait for

- ripgrep
- vim-tux?
- neovim, neovide
- okular
- (fonts - or a font manager)
- Insync

### From Manual Installs

- firefox -> "Mozilla Firefox", Mozilla.Firefox
- git -> Git or "Microsoft Git", Git.Git
- (git credential manager) -> "Git Credential Manager Core"
  (Microsoft.GitCredentialManagerCore) OR "MicrosoftGitCredentialManagerforWindows"
  (Microsoft.GitCredentialManagerforWindows)
- (github desktop) -> "GitHub Desktop" (GitHub.GitHubDesktop)
- (github cli) -> "GitHub CLI" (GitHub.cli)
- powershell-core -> PowerShell (Microsoft.PowerShell)
- vim-tux -> no, but do have Vim (vim.vim)
- virtualbox -> "Oracle VM VirtualBox" (Oracle.VirtualBox)

### From Main Apps

- 7zip -> 7-Zip (7zip.7zip)
- adoptopenjdk -> "AdoptOpenJDK 16.0.1+9" (AdoptOpenJDK.OpenJDK.16)
- autohotkey -> AutoHotKey (Lexikos.AutoHotkey)
- awscli -> "AWS Command Line Interface v2" (Amazon.AWSCLI)
- sam -> "AWS SAM Command Line Interface" (Amazon.SAM-CLI)
- beyondcomapre -> "Beyond Compare 4" (ScooterSoftware.BeyondCompare4)
- bitwarden -> Bitwarden (Bitwarden.Bitwarden)
- bitwarden-cli -> no
- bleachbit -> BleachBit (BleachBit.BleachBit)
- carnac -> Carnac (code52.Carnac)
- corretto -> "Corretto 16" (Amazon.Corretto.16)
- directoryopus -> "Directory Opus" (GPSoftware.DirectoryOpus)
- dos2unix -> no
- dotnet -> ".NET SDK", 5, (Microsoft.dotnet)
- dotnetfx -> ".net Framework" (Microsoft.dotNetFramework)
- dotnetcore-sdk -> ".NET Core Runtime", need the sdk (Microsoft.dotnetRuntime)
- drawio -> "draw.io" (JGraph.Draw)
- editorconfig.core -> no
- element-desktop -> "Element" (Element.Element)
- emacs -> "GNU Emacs" (GNU.Emacs)
- evernote -> Evernote (evernote.evernote)
- fd -> no
- ferdi -> Ferdi (AmineMouafik.Ferdi)
- (rambox) -> "Rambox Community Edition" (Rambox.RamboxCE)
- git-lfs -> "Git Large File Storage" (GitHub.GitLFS)
- gnupg -> GnuPG (GnuPG.GnuPG)
- golang -> Go (GoLang.Go)
- googlechrome -> "Google Chrome" (Google.Chrome)
- (ungoogled chromium) -> "Ungoogled Chromium" (eloston.ungoogled-chromium)
- jetbrainstoolbox -> "Toolbox" (JetBrains.Toolbox)
- kindle -> "Amazon Kindle" (Amazon.Kindle)
- libreoffice-still -> LibreOffice (LibreOffice.LibreOffice)
- microsoft-windows-terminal -> "Windows Terminal" (Microsoft.WindowsTerminal)
- neovim -> no
- neovide -> no
- (nodejs) -> "Node.js" (OpenJS.Nodejs)
- nodejs-lts -> "Node.js LTS" (OpenJS.NodeJSLTS)
- okular -> no
- pencil -> no
- plex -> "Plex Media Player" (plex.plexmediaplayer)
- (plex server) -> "Plex", this is the server one? (Plex.Plex)
- (plex server) -> "Plex Media Server" (plex.plexmediaserver)
- plexamp -> "Plexamp" (Plex.Plexamp)
- python -> "Python" (Python.Python) or "Python 3.9.5" (Python.Python.3) or "Python
  2.7.18" (Python.Python.2)
- ripgrep -> no
- scribus -> Scribus (Scribus.Scribus)
- shellcheck -> no
- signal -> Signal (Signal.Signal)
- speedcrunch -> SpeedCrunch (SpeedCrunch.SpeedCrunch)
- spotify -> Spotify (Spotify.Spotify)
- sysinternals -> no
- terraform -> no
- tflint -> no
- ubuntuhere -> no
- universal-ctags -> no
- vcredist-all -> no, "Microsoft Visual C++ 2015-2019 Redistributable (x64)"
  (Microsoft.VC++2015-2019Redist-x64)
- vlc -> "VLC media player" (VideoLAN.VLC)
- vscode -> "Visual Studio Code" (Microsoft.VisualStudioCode)
- (vscodium) -> "VSCodium" (VSCodium.VSCodium)
- which -> no
- windirstat -> WinDirStat (WDSTeam.WinDirStat)
- wsl-debiangnulinux - "Debian" (Debian.Debian)
- wsl-ubuntu-2004 - "Ubuntu" (Canonical.Ubuntu)
- (fedora) -> "Fedora Remix for WSL" (whitewaterfoundry.fedora-remix-for-wsl)
- (opensuse) -> "opensuse leap 42" (suse.opensuse-leap-42)
- (kali) -> "Kali Linux" (kalilinux.kalilinux)
- zerotier-one -> "ZeroTier" (zerotier.zerotier)

### Fonts

- hackfont -> "HackFonts" (SourceFoundry.HackFonts)
- nerdfont-hack -> no
- croscorefonts-font -> no
- crosextrafonts-caladea-font -> no
- crosextrafonts-carlito-font -> no
- cascadiafonts -> no
- cascadia-code-nerd-font -> no
- jetbrainsmono -> no
- noto -> no

### Non-Work Apps

- avidemux -> no
- handbrake -> HandBrake (HandBrake.HandBrake)
- mullvad-app -> "Mullvad VPN" (MullvadVPN.MullvadVPN)
- qbittorrent -> "qBittorrent" (qBittorrent.qBittorrent)

### Work Apps

- (chime) -> "Amazon Chime" (Amazon.Chime)
- amazon-workspaces -> "Amazon Workspaces Client" (Amazon.WorkspacesClient)
- microsoft-teams -> "Microsoft Teams" (Microsoft.Teams)
- slack -> Slack (SlackTechnologies.Slack)
- skype -> Skype (Microsoft.Skype)
- skypeforbusiness -> no
- zoom -> Zoom (Zoom.Zoom)

### Virtualization Apps

- packer -> no
- vagrant -> Vagrant (Hashicorp.Vagrant)

### Development Apps

- docker-desktop -> "Docker Desktop" (Docker.DockerDesktop)
- insomnia-rest-api-client -> Insomnia (Insomnia.Insomnia)
- rust-ms -> "Rust (Visual Studio ABI)" (Rustlang.rust-msvc) or "Rust (GNU ABI)"
  (Rustlang.rust-gnu)
- (visual studio)
  - "Visual Studio Professional 2019" (Microsoft.VisualStudio.2019.Professional)
  - "Visual Studio Community 2019" (Microsoft.VisualStudio.2019.Community)
  - "Visual Studio Build Tools 2019" (Microsoft.VisualStudio.2019.BuildTools)
  - "Visual Studio Test Agent 2019" (Microsoft.VisualStudio.2019.TestAgent)
  - "Visual Studio Load Test Controller 2019"
    (Microsoft.VisualStudio.2019.TestController)
  - "Visual Studio Enterprise 2019" (Microsoft.VisualStudio.2019.Enterprise)
  - "Remote Tools for Visual Studio 2019" (Microsoft.VisualStudio.2019.RemoteTools)
  - "Performance Tools for Visual Studio 2019"
    (Microsoft.VisualStudio.2019.StandaloneProfiler)

### Gaming Apps

- goggalaxy -> "GOG Galaxy" (GOG.Galaxy)
- steam -> Steam (Valve.Steam)
- steam-cleaner -> no
- uplay -> "Ubisoft Connect"? (Ubisoft.Connect)
- epicgameslauncher -> "Epic Games Launcher" (EpicGames.EpicGamesLauncher)
- twitch -> "Twitch App for Windows" (Twitch.Twitch)
- battle.net -> "Battle.Net" (Blizzard.BattleNet)
- origin -> "Playnite"? (Playnite.Playnite)

### Summary

67 apps out of 95 (86 excluding fonts), ~75% of apps

## Others of interest

- LibreWolf (LibreWolf.LibreWolf)
- Calibre (calibre.calibre)
- Amazon Send To Kindle (Amazon.SendToKindle)
- Alacritty (Alacritty.Alacritty)
- FontForge (FontForge.FontForge)
- KDiff3 (KDE.KDiff3)
- Mattermost Desktop (Mattermost.MattermostDesktop)
- Logitech Harmony Remote (Logitech.Harmony)
- Atom (GitHub.Atom)
- GitKraken (Axosoft.GitKraken)
- Joplin (Joplin.Joplin)
- "Windows Package Manager Manifest Creator" (Microsoft.WingetCreate)
- Krita (KDE.Krita)
- KDE Connect (KDE.KDEConnect)
- Kdenlive (KDE.Kdenlive)
- Office (Microsoft.Office)
- OBS Studio (OBSProject.OBSStudio)
- WireGuard (WireGuard.WireGuard)

- ActivePerl (ActiveState.ActivePerl)
- Amazon Music (Amazon.Music)
- JDownlaoder (AppWork.JDownloader)
- GhostScript (ArtifexSoftware.GhostScript)
- Audacity (Audacity.Audacity)
- Simplenote (Automattic.Simplenote)
- balenaEtcher (Balena.Etcher)
- balena-cli (Balena.BalenaCLI)
- Wavebox (Bookry.Wavebox)
- Brave (BraveSoftware.BraveBrowser)
- Brutal Chess (BrutalChess.BrutalChess)
- MikTeX (ChristianSchenk.MikTeX)
- Clementine (Clemintine.Clemintine)
- DOSBox (DOSBox.DOSBox)
- Discord (Discord.Discord)
- Dropbox (Dropbox.Dropbox)
- Far Manager 3 (FarManager.FarManager)
- Figma (Figma.Figma)
- Folding@home (FoldingAtHome.FoldingAtHome)
- FontBase? (FontBase.FontBase)
- GIMP (GIMP.GIMP)
- Midnight Commander (GNU.MidnightCommander)
- Geany (Geany.Geany)
- Total Commander (Ghisler.TotalCommander)
- Git Extensions (GitExtensionsTeam.GitExtensions)
- Gitter IM (Gitlab.Gitter.IM)
- Glimpse (Glimpse.Glimpse)
- GnuCash (GnuCash.GnuCash)
- Grep for Windows (GnuWin32.Grep)
- Make for Windows (GnuWin32.Make)
- WGet for Windows (GnuWin32.WGet)
- Zip for Windows (GnuWin32.Zip)
- Meld (Meld.Meld)
- MEGASync (Mega.MEGASync)
- Google Earth Pro (Google.EarthPro)
- Picasa (Google.Picasa)
- MakeMKV (GuinpinSoft.MakeMKV)
- HerokuCLI (Heroku.HerokuCLI)
- HexChat (HexChat.HexChat)
- ImageMagick (ImageMagick.ImageMagick)
- Inkscape (Inkscape.Inkscape)
- Nmap (Insecure.Nmap)
- Intel Driver & Support Assistant (Intel.IntelDriverAndSupportAssistant)
- IrfanView (IrfanSkiljan.IrfanView)
- The Silver Searcher (JFLarvoire.Ag)
- Inno Setup (JRSoftware.InnoSetup)
- Jellyfin (Jellyfin.Jellyfin)
- Jitsi Meet Electron (Jitsi.Meet)
- Pandoc (JohnMacFarlane.Pandoc)
- Julia (Julialang.Julia)
- digikam (KDE.digikam)
- CMake (Kitware.CMake)
- LBRY (LBRY.LBRY)
- Lenovo System Update (Lenovo.SystemUpdate)
- FontBase (Levitsky.FontBase)
- LibreCAD (LibreCAD.LibreCAD)
- MKVToolNix (MKVToolNix.MKVToolNix)
- Clink (MRidgers.Clink)
- TesseractOCR (MannheimUniversityLibrary.TesseractOCR)
- MariDB Server (MariaDB.Server)
- Shotcut (Meltytech.Shotcut)
- Microsoft Edge (Microsoft.Edge)
- Mouse and Keyboard Center (Microsoft.MouseandKeyboardCenter)
- NuGet (Microsoft.NuGet)
- OneDrive (Microsoft.OneDrive)
- Microsoft OpenJDK 16 (Microsoft.OpenJDK.16)
- PowerToys (Microsoft.PowerToys)
- Remote Desktop Client (Microsoft.RemoteDesktopClient)
- SQL Server Management Studio (Microsoft.SQLServerManagementStudio)
- Windows 10 Update Assistant (Microsoft.UpdateAssistant)
- Windows SDK (Microsoft.WindowsSDK)
- Minecraft Launcher (Mojang.MinecraftLauncher)
- Pale Moon (MoonchildProductions.PaleMoon)
- Mozilla Thunderbird (Mozilla.Thunderbird)
- Mp3tag (Mp3tag.Mp3tag)
- Mumble (Mumble.Mumble)
- Musescore (Musescore.Musescore)
- Musicbrainz Picard (MusicBrainz.Picard)
- MyPaint (MyPaint.MyPaint)
- NASM (NASM.NASM)
- Nullsoft Scriptable Installer (NSIS.NSIS)
- NextDNS (NextDNS.NextDNS)
- Nextcloud Desktop (Nextcloud.NextcloudDesktop)
- ShellExView (Nirsoft.ShellExView)
- Notepad++ (Notepad++.Notepad++)
- Notion (Notion.Notion)
- Nozbe Personal (Nozbe.NozbePersonal)
- NuGetPackageExplorer (NuGetPackageExplorer.NuGetPackageExplorer)
- Nvidia GeForce Experience (Nvidia.GeForceExperience)
- NVIDIA GeForce NOW (Nvidia.GeForceNow)
- Obsidian (Obsidian.Obsidian)
- Octopus Deploy Server (OctopusDeploy.Server)
- Octopus Tentacle (OctopusDeploy.Tentacle)
- Olive Video Editor (OliveTeam.OliveVideoEditor)
- PandocGui (Ombrelin.PandocGui)
- OpenShot (OpenShot.OpenShot)
- MySQL (Oracle.MySQL)
- Oracle Java (Oracle.JavaRuntimeEnvironment)
- Paradox Launcher (ParadoxInteractie.ParadoxLauncher)
- Pidgin IM (Pidgin.Pidgin)
- PlayStation Now (PlayStation.PSNow)
- PostgreSQL (PostgreSQL.PostgreSQL)
- pgAdmin4 (PostgreSQL.pgAdmin)
- Postman (Postman.Postman)
- Puppet Development Kit (Puppet.pdk)
- Puppet Agent (Puppet.Puppet-agent)
- Puppet Bolt (Puppet.puppet-bolt)
- Chef (chef.chefdk)
- Qalculate! (Qalculate.Qalculate)
- Winamp (Radionomy.Winamp)
- Reddit-Wallpaper-Changer (Rawns.Reddit-Wallpaper-Changer)
- Razer Synapse (Razer.Synapse)
- VNCViewer (RealVNC.VNCViewer)
- Rocket.Chat (RocketChat.RocketChat)
- Ruby (RubyInstallerTeam.Ruby)
- Ruby with DevKit (RubyInstallerTeam.RubyWithDevKit)
- Rufus (Rufus.Rufus)
- Jami (SFLinux.Jami)
- SSHFS-Win (SSHFS-Win.SSHFS-Win)
- WinFsp (WinFsp.WinFsp)
- SiriKali -> no
- SSHFS-Win-Manager
- Salt Minion (SaltStack.SaltMinion)
- scala (Scala.scala)
- TagScanner (SergeySerkov.TagScanner)
- OpenSSL (ShiningLight.OpenSSLLight)
- StandardNotes (StandardNotes.StandardNotes)
- GitHubReleaseNotes (StefHeyenrath.GitHubReleaseNotes)
- Franz (StefanMalzner.Franz)
- Stellarium (Stellarium.Stellarium)
- Strawberry (StraberryMusicPlayer.Strawberry)
- Strawberry Perl (StrawberryPerl.StrawberryPerl)
- Streamlabs OBS (Streamlabs.StreamlabsOBS)
- Sublime Merge (SublimeHQ.SublimeMerge)
- Sublime Text 4 (SublimeHQ.SublimeText.4)
- SumatraPDF (SumatraPDF.SumatraPDF)
- TeX Live (TUG.TeXLive)
- TeXstudio (TeXstudio.TeXstudio)
- TeXworks (TeXworks.TeXworks)
- Texmaker (Texmaker.Texmaker)
- FileZilla (TimKosse.Filezilla)
- Filezilla Client (TimKosse.FilezillaClient)
- Toggl Desktop (Toggl.TogglDesktop)
- Colorpicker (Toinane.Colorpicker)
- Authy Desktop (Twilio.Authy)
- UltraVNC (UltraVNC.UltraVNC)
- Unity (UnityTechnologies.Unity)
- Waterfox (Waterfox.Waterfox)
- 0 AD (WildfireGames.0AD)
- WinMerge (WinMerge.WinMerge)
- WinSCP (WinSCP.WinSCP)
- Wireshark (WiresharkFoundation.Wireshark)
- Wolfram Engine (WolframResearch.WolframEngine)
- Yarn (Yarn.Yarn)
- Yubico Authenticator (Yubico.Authenticator)
- Yubikey Manager (Yubico.YubikeyManager)
- Hyper (Zeit.Hyper)
- Double Commander (alexx2000.DoubleCommander)
- darktable (darktable.darktable)
- devdocs desktop (egoist.devdocs-desktop)
- mqttx (emqx.mqttx)
- udemy downloader gui (faisalumair.udeler)
- f.lux (flux.flux)
- pomodoro (g07cha.pomodoro)
- gsudo (gerardog.gsudo)
- Dia (gnome.Dia)
- gedit (gnome.gedit)
- gnuplot (gnuplot.gnuplot)
- VcXsrv (marha.VcXsrv)
- ColorPicker (martinchrzan.ColorPicker)
- OpenHashTab (namazso.OpenHashTab)
- nomacs - Image Lounge (nomacs.nomacs)
- unsplash-wallpapers (soroushchehresa.unsplash-wallpapers)
- MQTT Explorer (thomasnordquist.MQTT-Explorer)
- Microsoft.WSL2KernelUpdate
- Microsoft.WinGet
