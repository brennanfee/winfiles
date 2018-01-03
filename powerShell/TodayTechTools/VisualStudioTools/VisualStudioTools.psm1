#### Functions Used to Load VS Command Prompt #####
function Get-Batchfile ($file) {
    $cmd = "`"$file`" & set"
    cmd /c $cmd | Foreach-Object {
        $p, $v = $_.split('=')
        Set-Item -path env:$p -value $v
    }
}

function Set-VsVars32($vsYear)
{
    $vstools = $env:VS100COMNTOOLS
    switch ($vsYear)
    {
        2008 {$vstools = $env:VS90COMNTOOLS}
        2010 {$vstools = $env:VS100COMNTOOLS}
        2012 {$vstools = $env:VS110COMNTOOLS}
        2013 {$vstools = $env:VS120COMNTOOLS}
    }

    $batchFile = [System.IO.Path]::Combine($vstools, "vsvars32.bat")
    # If that batch file doesn't exist default to 2013
    if (-not (Test-Path $batchFile)){
        $batchFile = [System.IO.Path]::Combine($env:VS120COMNTOOLS, "vsvars32.bat")
    }

    if (Test-Path $batchFile){
        Get-Batchfile -file $batchFile

        Write-Host -ForegroundColor 'Green' "VsVars has been loaded from: $batchFile"
    }
    else {
        Write-Host -ForegroundColor 'Yellow' "Unable to locate VsVars batch file: $batchFile"
    }
}

function Clear-Assemblies($directory)
{
    Get-ChildItem $directory -include bin,obj -Recurse | ForEach-Object ($_) {
        "Cleaning: " + $_.fullname
        remove-item $_.fullname -Force -Recurse
    }
}

function Set-CopyLocalFalse($projectFile, $doProjectReferences, $tfsCheckout)
{
    [xml]$s = get-content $projectFile

    $references = $s.Project.ItemGroup | Where-Object { $_.Reference -ne $null }
    $projectReferences = $s.Project.ItemGroup | Where-Object { $_.ProjectReference -ne $null }

    foreach($reference in $references.ChildNodes)
    {
        if($reference.Private -eq $null)
        {
            [System.Xml.XmlElement]$copyLocal = $s.CreateElement("Private", "http://schemas.microsoft.com/developer/msbuild/2003")
            $copyLocal.InnerText = "False"
            [Void]$reference.AppendChild($copyLocal)
        }
    }

    if($doProjectReferences -eq $true)
    {
        foreach($reference in $projectReferences.ChildNodes)
        {
            if($reference.Private -eq $null)
            {
                [System.Xml.XmlElement]$copyLocal = $s.CreateElement("Private", "http://schemas.microsoft.com/developer/msbuild/2003")
                $copyLocal.InnerText = "False"
                [Void]$reference.AppendChild($copyLocal)
            }
        }
    }

    if($tfsCheckout -eq $true)
    {
        Set-TFSCheckout $projectFile
    }

    $s.save($projectFile)
}

function Set-TFSCheckout($file)
{
    Write-Host -ForegroundColor 'Green' "Checking out " + $file
    tf checkout $file
}

function Set-SolutionWideCopyLocalFalse($directory, $doProjectReferences, $tfsCheckout)
{
    Get-ChildItem $directory -include *.csproj,*.vbproj -Recurse | foreach ($_) {
        Set-CopyLocalFalse $_.fullname $doProjectReferences $tfsCheckout
    }
}

function Get-ProjectsContainingReferenceTo($directory, $referenceName)
{
    Get-ChildItem $directory -include *.csproj,*.vbproj -Recurse | foreach ($_) {
        if(Get-ContainsReferenceTo $_.fullname $referenceName -eq $true){ $_.fullname }
    }
}

function Get-ProjectsContainingAProjectReferenceTo($directory, $referenceName)
{
    Get-ChildItem $directory -include *.csproj,*.vbproj -Recurse | foreach ($_) {
        if(Get-ContainsProjectReferenceTo $_.fullname $referenceName -eq $true){ $_.fullname }
    }
}

function Get-ContainsReferenceTo($projectFile, $referenceName)
{
    [xml]$s = get-content $projectFile

    $references = $s.Project.ItemGroup | Where-Object { $_.ProjectReference -ne $null }

    foreach($reference in $references.ChildNodes)
    {
        if($reference.Include -ne $null -and $reference.Include.StartsWith($referenceName))
        {
            return $true
        }
    }

    return $false
}

# Function to format all documents based on https://gist.github.com/984353
function Format-Document {
    param(
        [parameter(ValueFromPipelineByPropertyName = $true)]
        [string[]]$ProjectName
    )
    Process {
        $ProjectName | ForEach-Object {
                        Recurse-Project -ProjectName $_ -Action { param($item)
                        if($item.Type -eq 'Folder' -or !$item.Language) {
                            return
                        }

                        $window = $item.ProjectItem.Open('{7651A701-06E5-11D1-8EBD-00A0C90F26EA}')
                        if ($window) {
                            Write-Host "Processing `"$($item.ProjectItem.Name)`""
                            [System.Threading.Thread]::Sleep(100)
                            $window.Activate()
                            $Item.ProjectItem.Document.DTE.ExecuteCommand('Edit.FormatDocument')
                            $Item.ProjectItem.Document.DTE.ExecuteCommand('Edit.RemoveAndSort')
                            $window.Close(1)
                        }
                    }
        }
    }
}

function Recurse-Project {
    param(
        [parameter(ValueFromPipelineByPropertyName = $true)]
        [string[]]$ProjectName,
        [parameter(Mandatory = $true)]$Action
    )
    Process {
        # Convert project item guid into friendly name
        function Get-Type($kind) {
            switch($kind) {
                '{6BB5F8EE-4483-11D3-8BCF-00C04F8EC28C}' { 'File' }
                '{6BB5F8EF-4483-11D3-8BCF-00C04F8EC28C}' { 'Folder' }
                default { $kind }
            }
        }

        # Convert language guid to friendly name
        function Get-Language($item) {
            if(!$item.FileCodeModel) {
                return $null
            }

            $kind = $item.FileCodeModel.Language
            switch($kind) {
                '{B5E9BD34-6D3E-4B5D-925E-8A43B79820B4}' { 'C#' }
                '{B5E9BD33-6D3E-4B5D-925E-8A43B79820B4}' { 'VB' }
                default { $kind }
            }
        }

        # Walk over all project items running the action on each
        function Recurse-ProjectItems($projectItems, $action) {
            $projectItems | %{
                $obj = New-Object PSObject -Property @{
                    ProjectItem = $_
                    Type = Get-Type $_.Kind
                    Language = Get-Language $_
                }

                & $action $obj

                if($_.ProjectItems) {
                    Recurse-ProjectItems $_.ProjectItems $action
                }
            }
        }

        if($ProjectName) {
            $p = Get-Project $ProjectName
        }
        else {
            $p = Get-Project
        }

        $p | %{ Recurse-ProjectItems $_.ProjectItems $Action }
    }
}

# Statement completion for project names
if (Get-Module -Name powertab) {
    Register-TabExpansion 'Recurse-Project' -Type Command {
        ProjectName = { Get-Project -All | Select-Object -ExpandProperty Name }
    }
}
