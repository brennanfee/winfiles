@{
    ModuleVersion = '1.0.0'

    GUID = '8b71b98c-8169-49bd-86d9-cc9bb308ca5b'

    Author = 'Brennan Fee'

    Copyright = '(c) 2019 Brennan Fee. All rights reserved.'

    Description = 'Module to load and save the PowerShell command history'

    PowerShellVersion = '5.0'

    NestedModules = @('PsHistory.ps1')

    CmdletsToExport = ''

    VariablesToExport = @('psHistoryPath', 'psHistoryLength')

    FunctionsToExport = @('Initialize-PsHistory')

    AliasesToExport = ''
}
