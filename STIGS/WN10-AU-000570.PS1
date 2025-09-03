<#
.SYNOPSIS
    Enables failure auditing for the Detailed File Share audit policy 
    subcategory if not already enabled.

.NOTES
    Author          : Rayan Abu Omar 
    LinkedIn        : linkedin.com/in/rayan-abu-omar/
    GitHub          : github.com/rayanabuomar
    Date Created    : 22-08-2025
    Last Modified   : 22-08-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000570

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000570).ps1 
#>

# Define the Audit Policy Subcategory and desired setting
$Subcategory = "Detailed File Share"
$AuditFlag = "Failure"

# Get current audit policy
$currentSetting = (AuditPol /get /subcategory:"$Subcategory" /r | Select-String "$Subcategory").ToString()

# Check if the failure audit is already enabled
if ($currentSetting -notmatch "Failure") {
    # Enable auditing for Failure
    AuditPol /set /subcategory:"$Subcategory" /failure:enable
    Write-Output "Enabled auditing for $Subcategory failures."
} else {
    Write-Output "$Subcategory failure auditing is already enabled."
}

Write-Output "Remediation for STIG ID: WN10-AU-000570 complete."
