#!/usr/bin/env pwsh.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Get-ComputerDetails {
    <#
.SYNOPSIS
    Returns some details on the given machine.  Includes whether the machine is virtual and/or a laptop.
.DESCRIPTION
    Uses wmi (along with any optional credentials) to gather some key information on a computer, possibly remote.
    Along with whether or not the machine is a virtual it attempts to return which virtual platform is used.
    In situations where the machine is physical, attempts to determine if the machine is a laptop (has a battery).
.PARAMETER ComputerName
    Computer or IP address of machine
.PARAMETER Credential
    Provide an alternate credential
.EXAMPLE
    $Credential = Get-Credential
    Get-ComputerDetails "Server1" -Credential $Credential | select ComputerName,IsVirtual,VirtualType | ft
    Description:
    ------------------
    Using an alternate credential, determine if server1 is virtual. Return the results along with the type of virtual machine it might be.
.EXAMPLE
    (Get-ComputerDetails "server1").IsVirtual
    Description:
    ------------------
    Determine if server1 is virtual and returns either true or false.
.LINK
    https://www.linkedin.com/in/brennanfee
.NOTES
    Name       : Get-ComputerDetails
    Version    : 1.1.0 2017-05-06 Brennan Fee
                    - Converted to a proper module
    Version    : 1.0.0 2017-11-11 Brennan Fee
                    - First release
    Author     : Brennan Fee
#>
    param(
        [parameter(Position = 0, ValueFromPipeline = $true, HelpMessage = "Computer or IP address of machine to test")]
        [string]$ComputerName = $env:COMPUTERNAME,
        [parameter(HelpMessage = "Pass an alternate credential")]
        [System.Management.Automation.PSCredential]$Credential = $null
    )

    $result = @()
    $wmibios = @()
    $wmisystem = @()

    try {
        if ($Credential -ne $null) {
            $wmibios = Get-WmiObject -Class Win32_BIOS -ComputerName $ComputerName -Credential $Credential -ErrorAction Stop | Select-Object Version, SerialNumber
            $wmisystem = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ComputerName -Credential $Credential -ErrorAction Stop | Select-Object Name, Model, Manufacturer, PCSystemType, HypervisorPresent
        }
        else {
            $wmibios = Get-WmiObject -Class Win32_BIOS -ComputerName $ComputerName -ErrorAction Stop | Select-Object Version, SerialNumber
            $wmisystem = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ComputerName -ErrorAction Stop | Select-Object Name, Model, Manufacturer, PCSystemType, HypervisorPresent
        }

        $ResultProps = @{
            ComputerName = $wmisystem.Name
            BIOSVersion  = $wmibios.Version
            SerialNumber = $wmibios.SerialNumber
            Manufacturer = $wmisystem.Manufacturer
            Model        = $wmisystem.Model
            IsLaptop     = $false
            IsVirtual    = $false
            VirtualType  = $null
        }

        if ($wmisystem.PCSystemType -eq 2) {
            $ResultProps.IsLaptop = $true
        }

        if ($wmibios.SerialNumber -like "*VMware*") {
            $ResultProps.IsVirtual = $true
            $ResultProps.VirtualType = "VMWare"
        }
        else {
            switch -wildcard ($wmibios.Version) {
                'VIRTUAL' {
                    $ResultProps.IsVirtual = $true
                    $ResultProps.VirtualType = "Hyper-V"
                }
                'A M I' {
                    $ResultProps.IsVirtual = $true
                    $ResultProps.VirtualType = "Virtual PC"
                }
                '*Xen*' {
                    $ResultProps.IsVirtual = $true
                    $ResultProps.VirtualType = "Xen"
                }
                '*VBOX*' {
                    $ResultProps.IsVirtual = $true
                    $ResultProps.VirtualType = "VirtualBox"
                }
            }
        }

        if (-not $ResultProps.IsVirtual) {
            if ($wmisystem.Manufacturer -like "*Microsoft*") {
                $ResultProps.IsVirtual = $true
                $ResultProps.VirtualType = "Hyper-V"
            }
            elseif ($wmisystem.Manufacturer -like "*VMWare*") {
                $ResultProps.IsVirtual = $true
                $ResultProps.VirtualType = "VMWare"
            }
            elseif ($wmisystem.Model -eq "VirtualBox") {
                $ResultProps.IsVirtual = $true
                $ResultProps.VirtualType = "VirtualBox"
            }
            elseif ($wmisystem.Model -eq "KVM") {
                $ResultProps.IsVirtual = $true
                $ResultProps.VirtualType = "KVM"
            }
            elseif ($wmisystem.Model -like "*Virtual*") {
                $ResultProps.IsVirtual = $true
                $ResultProps.VirtualType = "Unknown"
            }
        }

        $ResultProps.BootMode = "Unknown"
        $ResultProps.WinVersionInfo = $null
        $ResultProps.WinVersionInfo = 0

        if ($ComputerName -eq $env:COMPUTERNAME) {
            # Windows Version Info
            $ResultProps.WinVersionInfo = [System.Environment]::OSVersion.Version
            $regKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
            $ResultProps.WinReleaseId = `
            (Get-ItemProperty -Path $regKey -Name ReleaseId).ReleaseId

            # Boot type (UEFI or BIOS)
            $pantherFile = "$env:SystemRoot\Panther\setupact.log"
            $bootMode = (Select-String 'Detected boot environment' $pantherFile -AllMatches ).Line -Replace '.*:\s+'
            if ($bootMode -eq "EFI") {
                $ResultProps.BootMode = "UEFI"
            } else {
                $ResultProps.BootMode = $bootMode
            }
        }

        $result += New-Object PsObject -Property $ResultProps
    }
    catch {
        Write-Warning "Cannot connect to $computer"
    }

    return $result
}
