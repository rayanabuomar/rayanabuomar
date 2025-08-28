<#
.SYNOPSIS
    

.NOTES
    Author          : Rayan Abu Omar 
    LinkedIn        : linkedin.com/in/rayan-abu-omar/
    GitHub          : github.com/rayanabuomar
    Date Created    : 22-08-2025
    Last Modified   : 22-08-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000365

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000365).ps1 
#>

# Remediation Script for STIG ID: WN10-CC-000365
# Windows 10 must be configured to prevent Windows apps from being activated by voice while the system is locked.

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy"
$RegName = "LetAppsActivateWithVoiceAboveLock"
$RegValue = 2  # Force Deny

# Ensure registry path exists
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
    Write-Output "Created registry path: $RegPath"
}

# Check current value
$currentValue = (Get-ItemProperty -Path $RegPath -Name $RegName -ErrorAction SilentlyContinue).$RegName

if ($currentValue -ne $RegValue) {
    New-ItemProperty -Path $RegPath -Name $RegName -Value $RegValue -PropertyType DWord -Force | Out-Null
    Write-Output "Set $RegName to $RegValue under $RegPath"
} else {
    Write-Output "$RegName is already correctly set to $RegValue"
}

# Optional: Also enforce full voice activation deny (NA case)
$GlobalBlockName = "LetAppsActivateWithVoice"
$GlobalBlockValue = 2

$currentGlobalValue = (Get-ItemProperty -Path $RegPath -Name $GlobalBlockName -ErrorAction SilentlyContinue).$GlobalBlockName

if ($currentGlobalValue -ne $GlobalBlockValue) {
    New-ItemProperty -Path $RegPath -Name $GlobalBlockName -Value $GlobalBlockValue -PropertyType DWord -Force | Out-Null
    Write-Output "Optionally set $GlobalBlockName to $GlobalBlockValue under $RegPath (global deny, makes requirement NA)"
} else {
    Write-Output "$GlobalBlockName already set to $GlobalBlockValue (global deny active)"
}

Write-Output "Remediation for STIG ID: WN10-CC-000365 complete. A reboot may be required."
