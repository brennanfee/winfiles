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

    FileList          = @(
        'ComputerDetails.psm1',
        'FileAndRegistryUtilities.psm1',
        'InvokeMsiInstaller.psm1',
        'PathUtilities.psm1',
        'PermissionUtilities.psm1'
    )

    CmdletsToExport = @(
        'Get-IsAdministrator',
        'Get-ComputerDetails',
        'Set-RegistryBool',
        'Set-RegistryInt',
        'Set-RegistryString',
        'Set-RegistryStringExpand',
        'Set-RegistryStringMulti',
        'Set-RegistryValue',
        'Set-RegistryOwnership',
        'Set-FileOwnership',
        'Set-FolderOwnership',
        'New-SymbolicLink-Safe',
        'New-SymbolicLink',
        'Invoke-MsiInstaller',
        'Invoke-MsiInstallerFromUrl',
        'Add-ToPath',
        'Remove-FromPath',

    )

    AliasesToExport = @('Set-DirectoryOwnership')
}
