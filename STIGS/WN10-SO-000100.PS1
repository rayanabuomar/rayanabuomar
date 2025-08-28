<#
.SYNOPSIS
    

.NOTES
    Author          : Rayan Abu Omar 
    LinkedIn        : linkedin.com/in/rayan-abu-omar/
    GitHub          : github.com/rayanabuomar
    Date Created    : 24-08-2025
    Last Modified   : 24-08-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000100

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-SO-000100).ps1 
#>

# Remediation Script for STIG ID: WN10-SO-000100
# The Windows SMB client must be configured to always perform SMB packet signing.

$RegPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"
$RegName = "RequireSecuritySignature"
$RegValue = 1

# Check if the registry path exists, if not create it
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
    Write-Output "Created registry path: $RegPath"
}

# Check current value
$currentValue = (Get-ItemProperty -Path $RegPath -Name $RegName -ErrorAction SilentlyContinue).$RegName

if ($currentValue -ne $RegValue) {
    # Set registry value
    New-ItemProperty -Path $RegPath -Name $RegName -Value $RegValue -PropertyType DWord -Force | Out-Null
    Write-Output "Set $RegName to $RegValue under $RegPath"
} else {
    Write-Output "$RegName is already set correctly to $RegValue"
}

Write-Output "Remediation for STIG ID: WN10-SO-000100 complete. A reboot may be required."
