<#
.SYNOPSIS
    Enforces a minimum password length of 14 characters by 
    updating and applying local security policy.

.NOTES
    Author          : Rayan Abu Omar 
    LinkedIn        : linkedin.com/in/rayan-abu-omar/
    GitHub          : github.com/rayanabuomar
    Date Created    : 16-08-2025
    Last Modified   : 16-08-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000035

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AC-000035).ps1 
#>

Import-Module ActiveDirectory

# Desired minimum password length
$MinPasswordLength = 14

# Get current local security policy for password length
$CurrentMinLength = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" -Name "MinimumPasswordLength" -ErrorAction SilentlyContinue).MinimumPasswordLength

# Apply the setting if needed
if ($CurrentMinLength -lt $MinPasswordLength -or $CurrentMinLength -eq $null) {
    secedit /export /cfg C:\Windows\Temp\secpol.cfg
    (Get-Content C:\Windows\Temp\secpol.cfg) -replace 'MinimumPasswordLength = \d+', "MinimumPasswordLength = $MinPasswordLength" | Set-Content C:\Windows\Temp\secpol.cfg
    secedit /configure /db C:\Windows\security\local.sdb /cfg C:\Windows\Temp\secpol.cfg /areas SECURITYPOLICY
    Write-Output "Minimum password length set to $MinPasswordLength characters."
} else {
    Write-Output "Minimum password length is already $CurrentMinLength."
}

# Clean up temporary file
Remove-Item C:\Windows\Temp\secpol.cfg -Force
