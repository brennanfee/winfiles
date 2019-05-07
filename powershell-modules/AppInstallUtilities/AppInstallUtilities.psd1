@{
    ModuleVersion     = '1.0.0'

    GUID              = 'e1f5aab9-1b9b-40f0-9596-e03432943f39'

    Author            = 'Brennan Fee'

    Copyright         = '(c) 2019 Brennan Fee. All rights reserved.'

    Description       = 'Utility methods to install and configure applications.'

    FileList          = @('InvokeMsiInstaller.psm1')

    FunctionsToExport = @('Invoke-*')
}
