<#
.SYNOPSIS
    

.NOTES
    Author          : Rayan Abu Omar 
    LinkedIn        : linkedin.com/in/rayan-abu-omar/
    GitHub          : github.com/rayanabuomar
    Date Created    : 25-08-2025
    Last Modified   : 25-08-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000085

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000085).ps1 
#>

$RegPath = "HKLM:\SYSTEM\CurrentControlSet\Policies\EarlyLaunch"
$ValueName = "DriverLoadPolicy"
$DesiredValue = 3  # Good, unknown, and bad but critical (prevents "bad")

# Ensure registry path exists
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
    Write-Output "Created registry path: $RegPath"
}

# Get current value
$currentValue = (Get-ItemProperty -Path $RegPath -Name $ValueName -ErrorAction SilentlyContinue).$ValueName

# Apply desired setting if needed
if ($currentValue -ne $DesiredValue) {
    Set-ItemProperty -Path $RegPath -Name $ValueName -Value $DesiredValue -Type DWord
    Write-Output "Set $ValueName = $DesiredValue (Good, unknown, and bad but critical)"
} else {
    Write-Output "$ValueName is already configured correctly."
}

Write-Output "ELAM Boot-Start Driver Initialization Policy remediation complete."
