@{
    ModuleVersion     = '1.0.0'

    GUID              = '1e581f7d-584d-40bf-b0f3-3d1ee63164f8'

    Author            = 'Brennan Fee'

    Copyright         = '(c) 2019 Brennan Fee. All rights reserved.'

    Description       = 'Collection of utilities for system management and information.'

    PowerShellVersion = '5.0'

    RequiredModules = @(
        @{
            ModuleName="Pscx";
            ModuleVersion="3.3.0";
            Guid="0fab0d39-2f29-4e79-ab9a-fd750c66e6c5"
        }
    )

    NestedModules = @(
        'ComputerDetails.ps1',
        'EditorUtilities.ps1',
        'FileAndRegistryUtilities.ps1',
        'InvokeMsiInstaller.ps1',
        'LocationUtilities.ps1',
        'PathUtilities.ps1',
        'PermissionUtilities.ps1',
        'GitTools.ps1'
    )

    CmdletsToExport = ''

    VariablesToExport = ''

    FunctionsToExport = @(
        'Add-ToPath',
        'Get-ApplicationPath',
        'Get-ComputerDetails',
        'Get-DefaultAtomExe',
        'Get-DefaultEmacsExe',
        'Get-DefaultSublimeTextExe',
        'Get-DefaultVimExe',
        'Get-DefaultVSCodeExe',
        'Get-GitBranchName',
        'Get-GitExe',
        'Get-GitInARepo',
        'Get-GitRootPath',
        'Get-IsAdministrator',
        'Get-SpecialFolder',
        'Invoke-MsiInstaller',
        'Invoke-MsiInstallerFromUrl',
        'New-SymbolicLink',
        'New-SymbolicLinkSafe',
        'Remove-FromPath',
        'Remove-GitMissingFiles',
        'Set-Editor',
        'Set-EditorToAtom',
        'Set-EditorToEmacs',
        'Set-EditorToNotepad',
        'Set-EditorToSublime',
        'Set-EditorToVim',
        'Set-EditorToVSCode',
        'Set-FileOwnership',
        'Set-FolderOwnership',
        'Set-ProfileLocation',
        'Set-RegistryBool',
        'Set-RegistryInt',
        'Set-RegistryOwnership',
        'Set-RegistryString',
        'Set-RegistryStringExpand',
        'Set-RegistryStringMulti',
        'Set-RegistryValue',

        'Invoke-Git*',
        'Set-LocationTo*'
    )

    AliasesToExport = @(
        'Set-DirectoryOwnership',
        'Set-LocationToHome'
    )
}
