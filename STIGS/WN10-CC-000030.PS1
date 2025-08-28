<#
.SYNOPSIS
    

.NOTES
    Author          : Rayan Abu Omar 
    LinkedIn        : linkedin.com/in/rayan-abu-omar/
    GitHub          : github.com/rayanabuomar
    Date Created    : 27-08-2025
    Last Modified   : 27-08-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000030

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000030).ps1 
#>

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"

# Step 1: Ensure registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
    Write-Output "Created registry path: $regPath"
} else {
    Write-Output "Registry path exists: $regPath"
}

# Step 2: Set EnableICMPRedirect = 0 (disable ICMP redirect overrides)
New-ItemProperty -Path $regPath -Name "EnableICMPRedirect" -PropertyType DWORD -Value 0 -Force
Write-Output "Set EnableICMPRedirect to 0 (ICMP redirects disabled)."

# Step 3: Verify setting
Write-Output "`nVerifying registry setting..."
Get-ItemProperty -Path $regPath -Name EnableICMPRedirect | Format-List

Write-Output "`nICMP redirect remediation completed."
