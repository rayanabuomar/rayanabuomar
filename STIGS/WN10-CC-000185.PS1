<#
.SYNOPSIS
    Disables AutoRun commands by setting the NoAutorun registry value to 1.

.NOTES
    Author          : Rayan Abu Omar 
    LinkedIn        : linkedin.com/in/rayan-abu-omar/
    GitHub          : github.com/rayanabuomar
    Date Created    : 26-08-2025
    Last Modified   : 26-08-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000185

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000185).ps1 
#>

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"

# Step 1: Ensure registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
    Write-Output "Created registry path: $regPath"
} else {
    Write-Output "Registry path exists: $regPath"
}

# Step 2: Set NoAutorun = 1 (disable AutoRun)
New-ItemProperty -Path $regPath -Name "NoAutorun" -PropertyType DWORD -Value 1 -Force
Write-Output "Set NoAutorun to 1 (disable AutoRun commands)."

# Step 3: Verify setting
Write-Output "`nVerifying registry setting..."
Get-ItemProperty -Path $regPath -Name NoAutorun | Format-List

Write-Output "`nAutoRun remediation completed."
