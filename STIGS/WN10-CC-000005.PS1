<#
.SYNOPSIS
   Disables lock screen camera access by setting the NoLockScreenCamera 
   registry value to 1.

.NOTES
    Author          : Rayan Abu Omar 
    LinkedIn        : linkedin.com/in/rayan-abu-omar/
    GitHub          : github.com/rayanabuomar
    Date Created    : 24-08-2025
    Last Modified   : 24-08-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000005).ps1 
#>

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"

# Step 1: Ensure registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
    Write-Output "Created registry path: $regPath"
} else {
    Write-Output "Registry path exists: $regPath"
}

# Step 2: Set NoLockScreenCamera = 1 (disable lock screen camera access)
New-ItemProperty -Path $regPath -Name "NoLockScreenCamera" -PropertyType DWORD -Value 1 -Force
Write-Output "Set NoLockScreenCamera to 1 (lock screen camera disabled)."

# Step 3: Verify setting
Write-Output "`nVerifying registry setting..."
Get-ItemProperty -Path $regPath -Name NoLockScreenCamera | Format-List

Write-Output "`nLock screen camera remediation completed."
