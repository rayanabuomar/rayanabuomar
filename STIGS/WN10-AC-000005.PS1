 <#
.SYNOPSIS
    Configures the account lockout duration to 15 minutes 
    (or admin unlock) and verifies the policy setting.

.NOTES
    Author          : Rayan Abu Omar 
    LinkedIn        : linkedin.com/in/rayan-abu-omar/
    GitHub          : github.com/rayanabuomar
    Date Created    : 27-08-2025
    Last Modified   : 27-08-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AC-000005).ps1 
#>

# Step 1: Set the lockout duration to 15 minutes
# Note: "0" means admin must unlock, which is also compliant
$lockoutDuration = 15
Write-Output "Configuring account lockout duration to $lockoutDuration minutes..."
net accounts /lockoutduration:$lockoutDuration

# Step 2: Verify the setting
Write-Output "`nVerifying account lockout policy..."
net accounts | findstr /i "lockout"

Write-Output "`nAccount lockout duration remediation completed."

