<#
.SYNOPSIS
    Disables printing over HTTP by setting the DisableHTTPPrinting 
    registry value to 1.

.NOTES
    Author          : Rayan Abu Omar 
    LinkedIn        : linkedin.com/in/rayan-abu-omar/
    GitHub          : github.com/rayanabuomar
    Date Created    : 27-08-2025
    Last Modified   : 27-08-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000110

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000110).ps1 
#>

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$RegName = "DisableHTTPPrinting"
$RegValue = 1  # Disable printing over HTTP

# Ensure registry path exists
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
    Write-Output "Created registry path: $RegPath"
}

# Get current value
$currentValue = (Get-ItemProperty -Path $RegPath -Name $RegName -ErrorAction SilentlyContinue).$RegName

# Compare and update if necessary
if ($currentValue -ne $RegValue) {
    New-ItemProperty -Path $RegPath -Name $RegName -Value $RegValue -PropertyType DWord -Force | Out-Null
    Write-Output "Set $RegName to $RegValue under $RegPath (Printing over HTTP disabled)"
} else {
    Write-Output "$RegName is already set correctly to $RegValue"
}

Write-Output "Remediation for STIG ID: WN10-CC-000110 complete. No reboot required."
