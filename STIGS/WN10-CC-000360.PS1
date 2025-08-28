<#
.SYNOPSIS
    

.NOTES
    Author          : Rayan Abu Omar 
    LinkedIn        : linkedin.com/in/rayan-abu-omar/
    GitHub          : github.com/rayanabuomar
    Date Created    : 23-08-2025
    Last Modified   : 23-08-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000360

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000360).ps1 
#>

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client"
$ValueName = "AllowDigest"
$DesiredValue = 0

# Ensure registry path exists
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
    Write-Output "Created registry path: $RegPath"
}

# Check current value
$currentValue = (Get-ItemProperty -Path $RegPath -Name $ValueName -ErrorAction SilentlyContinue).$ValueName

# Set value if missing or incorrect
if ($currentValue -ne $DesiredValue) {
    New-ItemProperty -Path $RegPath -Name $ValueName -PropertyType DWORD -Value $DesiredValue -Force | Out-Null
    Write-Output "Set $ValueName = $DesiredValue"
} else {
    Write-Output "$ValueName is already configured correctly."
}

Write-Output "Remediation for STIG ID: WN10-CC-000360 complete."
