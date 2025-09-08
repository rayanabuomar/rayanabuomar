<#
.SYNOPSIS
    Disables Autoplay for non-volume devices by setting the 
    NoAutoplayfornonVolume registry value to 1.

.NOTES
    Author          : Rayan Abu Omar 
    LinkedIn        : linkedin.com/in/rayan-abu-omar/
    GitHub          : github.com/rayanabuomar
    Date Created    : 12-07-2025
    Last Modified   : 12-07-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000180

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000180).ps1 
#>

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
$ValueName = "NoAutoplayfornonVolume"
$ValueData = 1

# Ensure registry path exists
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
    Write-Output "Created registry path: $RegPath"
}

# Set the registry value
$currentValue = (Get-ItemProperty -Path $RegPath -Name $ValueName -ErrorAction SilentlyContinue).$ValueName
if ($currentValue -ne $ValueData) {
    New-ItemProperty -Path $RegPath -Name $ValueName -PropertyType DWord -Value $ValueData -Force | Out-Null
    Write-Output "Set $ValueName = $ValueData"
} else {
    Write-Output "$ValueName is already configured correctly."
}

Write-Output "Remediation for STIG ID: WN10-CC-000180 complete. A reboot may be recommended."
