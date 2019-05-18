function Set-LocationToNewDir {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [string]
        $Path
    )

    $pwd = Get-Location
    $newPath = Join-Path "$pwd" "$Path"
    New-Item -Path $newPath -ItemType Directory -ErrorAction SilentlyContinue

    if (-not (Test-Path $newPath)) {
        Write-Error "Unable to create path $newPath"
    }

    Set-Location $newPath.Path
}

Set-Alias mkcd Set-LocationToNewDir
