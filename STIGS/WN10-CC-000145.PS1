<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Rayan Abu Omar 
    LinkedIn        : linkedin.com/in/rayan-abu-omar/
    GitHub          : github.com/rayanabuomar
    Date Created    : 26-08-2025
    Last Modified   : 26-08-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000145

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000145).ps1 
#>
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51"

# Step 1: Ensure registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
    Write-Output "Created registry path: $regPath"
} else {
    Write-Output "Registry path exists: $regPath"
}

# Step 2: Set DCSettingIndex = 1 (require password on resume from sleep when on battery)
New-ItemProperty -Path $regPath -Name "DCSettingIndex" -PropertyType DWORD -Value 1 -Force
Write-Output "Set DCSettingIndex to 1 (require password on resume when on battery)."

# Step 3: Verify setting
Write-Output "`nVerifying registry setting..."
Get-ItemProperty -Path $regPath -Name DCSettingIndex | Format-List

Write-Output "`nPassword on resume (battery) remediation completed."
