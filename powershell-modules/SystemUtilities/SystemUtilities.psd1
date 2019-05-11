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
        'PermissionUtilities.ps1'
    )

    CmdletsToExport = @(
        'Get-ComputerDetails',
        'Set-Editor',
        'Set-EditorToVim',
        'Set-EditorToEmacs',
        'Set-EditorToVSCode',
        'Set-EditorToSublime',
        'Set-EditorToAtom',
        'Set-EditorToNotepad',
        'Set-RegistryBool',
        'Set-RegistryInt',
        'Set-RegistryString',
        'Set-RegistryStringExpand',
        'Set-RegistryStringMulti',
        'Set-RegistryValue',
        'Set-RegistryOwnership',
        'Set-FileOwnership',
        'Set-FolderOwnership',
        'New-SymbolicLinkSafe',
        'New-SymbolicLink',
        'Invoke-MsiInstaller',
        'Invoke-MsiInstallerFromUrl',
        'Get-SpecialFolder',
        'Set-ProfileLocation',
        'Switch-ToSpecialFolder',
        'Switch-ToProfileFolder',
        'Add-ToPath',
        'Remove-FromPath',
        'Get-IsAdministrator'
    )

    VariablesToExport = ''

    FunctionsToExport = ''

    AliasesToExport = @('Set-DirectoryOwnership')
}
