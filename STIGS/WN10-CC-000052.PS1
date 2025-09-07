<#
.SYNOPSIS
    Enforces approved ECC curve order (NistP384, NistP256) for SSL
    by updating the EccCurves registry setting.

.NOTES
    Author          : Rayan Abu Omar 
    LinkedIn        : linkedin.com/in/rayan-abu-omar/
    GitHub          : github.com/rayanabuomar
    Date Created    : 27-08-2025
    Last Modified   : 27-08-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000052

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000052).ps1 
#>

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002"
$RegName = "EccCurves"
$RegValue = @("NistP384","NistP256")  # Longer key first

# Ensure registry path exists
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
    Write-Output "Created registry path: $RegPath"
}

# Get current value
$currentValue = (Get-ItemProperty -Path $RegPath -Name $RegName -ErrorAction SilentlyContinue).$RegName

# Compare and update if necessary
if ($null -eq $currentValue -or -not ($currentValue -eq $RegValue)) {
    Set-ItemProperty -Path $RegPath -Name $RegName -Value $RegValue -Type MultiString -Force
    Write-Output "Set $RegName to $($RegValue -join ', ') under $RegPath"
} else {
    Write-Output "$RegName is already configured correctly."
}

Write-Output "Remediation for STIG ID: WN10-CC-000052 complete. A reboot may be required for SSL services to pick up the new curve order."
