# Typo's
Set-Alias cd. Set-LocationToParent
Set-Alias cd.. Set-LocationToParent
# cd "up"
Set-Alias cdu Set-LocationToParent

Set-Alias cdp Set-LocationToProfileFolder

Set-Alias cdk Set-LocationToDesktop

function Set-LocationToTemplates { Set-LocationToProfileFolder "Templates" }
Set-Alias cdl Set-LocationToTemplates

function Set-LocationToSource { Set-LocationToProfileFolder "source" }
Set-Alias cds Set-LocationToSource

function Set-LocationToSourcePersonal { Set-LocationToProfileFolder "source\personal" }
Set-Alias cdss Set-LocationToSourcePersonal

function Set-LocationToSourceGithub { Set-LocationToProfileFolder "source\github" }
Set-Alias cdsg Set-LocationToSourceGithub

function Set-LocationToDownloads { Set-LocationToProfileFolder "downloads" }
Set-Alias cdd Set-LocationToDownloads

function Set-LocationToInstalls { Set-LocationToProfileFolder "downloads\installs" }
Set-Alias cdi Set-LocationToInstalls

Set-Alias cdm Set-LocationToMusic

function Set-LocationToMusicPlaylist { Set-LocationToSpecialFolder "MyMusic" "playlists" }
Set-Alias cdmp Set-LocationToMusicPlaylist
Set-Alias cdpl Set-LocationToMusicPlaylist

function Set-LocationToMounts { Set-LocationToProfileFolder "mounts" }
Set-Alias cdmt Set-LocationToMounts

Set-Alias cdv Set-LocationToVideos

function Set-LocationToVms { Set-LocationToProfileFolder "vms" }
Set-Alias cdvm Set-LocationToVms

function Set-LocationToDropbox { Set-LocationToProfileFolder "dropbox" }
Set-Alias cddb Set-LocationToDropbox

function Set-LocationToCloud { Set-LocationToProfileFolder "cloud" }
Set-Alias cdc Set-LocationToCloud

Set-Alias cdmd Set-LocationToMyDocuments

#NOTE: This is NOT the "My Documents" special folder
function Set-LocationToDocuments { Set-LocationToProfileFolder "documents" }
Set-Alias cdoc Set-LocationToDocuments

Set-Alias cdx Set-LocationToPictures

Set-Alias cdh Set-LocationToHome

function Set-LocationToWinfiles { Set-LocationToProfileFolder "winfiles" }
Set-Alias cdw Set-LocationToWinfiles

Set-Alias mkcd Set-LocationToNewDir
