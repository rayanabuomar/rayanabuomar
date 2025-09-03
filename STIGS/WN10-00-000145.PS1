<#
.SYNOPSIS
    Ensures Data Execution Prevention (DEP) is set to at least OptOut;
    updates configuration if needed and prompts for reboot.

.NOTES
    Author          : Rayan Abu Omar 
    LinkedIn        : linkedin.com/in/rayan-abu-omar/
    GitHub          : github.com/rayanabuomar
    Date Created    : 29-07-2025
    Last Modified   : 29-07-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000145

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-00-000145).ps1 
#>

# Verify current DEP setting
$currentDEP = bcdedit /enum "{current}" | Select-String "nx"

Write-Output "Current DEP setting:"
Write-Output $currentDEP

# If DEP is not at least OptOut, set it
if ($currentDEP -notmatch "OptOut|AlwaysOn") {
    Write-Output "Setting DEP to OptOut..."
    bcdedit /set "{current}" nx OptOut
    Write-Output "DEP has been configured to OptOut. A reboot is required for changes to take effect."
} else {
    Write-Output "DEP is already configured to OptOut or more restrictive (AlwaysOn). No changes needed."
}
