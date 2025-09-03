<#
.SYNOPSIS
    Sets the account lockout counter reset time to 15 minutes 
    by updating and applying local security policy.

.NOTES
    Author          : Rayan Abu Omar 
    LinkedIn        : linkedin.com/in/rayan-abu-omar/
    GitHub          : github.com/rayanabuomar
    Date Created    : 25-08-2025
    Last Modified   : 25-08-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000015

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AC-000015).ps1 
#>

# Set the account lockout counter reset time to 15 minutes
secedit /export /cfg C:\Windows\Temp\secpol.cfg
(Get-Content C:\Windows\Temp\secpol.cfg).ForEach({
    if ($_ -match "^ResetLockoutCount") {
        "ResetLockoutCount = 15"
    } else {
        $_
    }
}) | Set-Content C:\Windows\Temp\secpol.cfg

# Apply the updated security policy
secedit /configure /db C:\Windows\Security\Database\secedit.sdb /cfg C:\Windows\Temp\secpol.cfg /areas SECURITYPOLICY

Write-Output "Account lockout counter reset time set to 15 minutes."
