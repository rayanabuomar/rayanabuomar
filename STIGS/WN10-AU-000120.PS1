<#
.SYNOPSIS
    Enables auditing of IPSec Driver failures and ensures 
    audit subcategory settings override category settings.

.NOTES
    Author          : Rayan Abu Omar 
    LinkedIn        : linkedin.com/in/rayan-abu-omar/
    GitHub          : github.com/rayanabuomar
    Date Created    : 26-08-2025
    Last Modified   : 26-08-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000120

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000120).ps1 
#>

# Ensure Audit Policy subcategories override categories
AuditPol /set /subcategory:"Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings" /success:enable /failure:enable 2>$null

# Enable auditing of IPSec Driver failures
AuditPol /set /subcategory:"IPSec Driver" /failure:enable 2>$null

Write-Output "Audit for IPSec Driver failures has been configured."
