<#
.SYNOPSIS
    Disables the Secondary Logon (seclogon) service by stopping it (if running) 
    and setting its startup type to Disabled.

.NOTES
    Author          : Rayan Abu Omar 
    LinkedIn        : linkedin.com/in/rayan-abu-omar/
    GitHub          : github.com/rayanabuomar
    Date Created    : 18-07-2025
    Last Modified   : 18-07-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000175

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-00-000175).ps1 
#>

$ServiceName = "seclogon"

# Stop the service if it is running
if ((Get-Service -Name $ServiceName).Status -ne 'Stopped') {
    Stop-Service -Name $ServiceName -Force
    Write-Output "Stopped service: $ServiceName"
} else {
    Write-Output "Service $ServiceName is already stopped."
}

# Set the service startup type to Disabled
Set-Service -Name $ServiceName -StartupType Disabled
Write-Output "Set $ServiceName startup type to Disabled."

Write-Output "Remediation for STIG ID: WN10-00-000175 complete."
