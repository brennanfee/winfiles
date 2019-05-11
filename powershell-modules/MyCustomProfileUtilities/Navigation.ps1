# Typo's
Set-Alias cd. Switch-LocationToParent
Set-Alias cd.. Switch-LocationToParent
# cd "up"
Set-Alias cdu Switch-LocationToParent

Set-Alias cdp Switch-LocationToProfileFolder

Set-Alias cdk Switch-LocationToDesktop

function Switch-LocationToTemplates { Switch-LocationToProfileFolder "Templates" }
Set-Alias cdl Switch-LocationToTemplates

function Switch-LocationToSource { Switch-LocationToProfileFolder "source" }
Set-Alias cds Switch-LocationToSource

function Switch-LocationToSourcePersonal { Switch-LocationToProfileFolder "source\personal" }
Set-Alias cdss Switch-LocationToSourcePersonal

function Switch-LocationToSourceGithub { Switch-LocationToProfileFolder "source\github" }
Set-Alias cdsg Switch-LocationToSourceGithub

function Switch-LocationToDownloads { Switch-LocationToProfileFolder "downloads" }
Set-Alias cdd Switch-LocationToDownloads

function Switch-LocationToInstalls { Switch-LocationToProfileFolder "downloads\installs" }
Set-Alias cdi Switch-LocationToInstalls

Set-Alias cdm Switch-LocationToMusic

function Switch-LocationToMusicPlaylist { Switch-LocationToSpecialFolder "MyMusic" "playlists" }
Set-Alias cdmp Switch-LocationToMusicPlaylist

function Switch-LocationToMounts { Switch-LocationToProfileFolder "mounts" }
Set-Alias cdmt Switch-LocationToMounts

Set-Alias cdv Switch-LocationToVideos

function Switch-LocationToVms { Switch-LocationToProfileFolder "vms" }
Set-Alias cdvm Switch-LocationToVms

function Switch-LocationToDropbox { Switch-LocationToProfileFolder "dropbox" }
Set-Alias cddb Switch-LocationToDropbox

function Switch-LocationToCloud { Switch-LocationToProfileFolder "cloud" }
Set-Alias cdc Switch-LocationToCloud

Set-Alias cdmd Switch-LocationToMyDocuments

#NOTE: This is NOT the "My Documents" special folder
function Switch-LocationToDocuments { Switch-LocationToProfileFolder "documents" }
Set-Alias cdoc Switch-LocationToDocuments

Set-Alias cdx Switch-LocationToPictures

Set-Alias cdh Switch-LocationToHome

function Switch-LocationToWinfiles { Switch-LocationToProfileFolder "winfiles" }
Set-Alias cdw Switch-LocationToWinfiles

#TODO: cdr - to to root of git folder
