<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Rayan Abu Omar 
    LinkedIn        : linkedin.com/in/rayan-abu-omar/
    GitHub          : github.com/rayanabuomar
    Date Created    : 25-08-2025
    Last Modified   : 25-08-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000255

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-SO-000255).ps1 
#>

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

# Step 1: Ensure registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
    Write-Output "Created registry path: $regPath"
} else {
    Write-Output "Registry path exists: $regPath"
}

# Step 2: Set ConsentPromptBehaviorUser = 0
New-ItemProperty -Path $regPath -Name "ConsentPromptBehaviorUser" -PropertyType DWORD -Value 0 -Force
Write-Output "Set ConsentPromptBehaviorUser to 0 (automatically deny elevation requests for standard users)."

# Step 3: Verify setting
Write-Output "`nVerifying registry setting..."
Get-ItemProperty -Path $regPath -Name ConsentPromptBehaviorUser | Format-List

Write-Output "`nUAC standard user elevation remediation completed."
