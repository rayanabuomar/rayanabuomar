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
    STIG-ID         : WN10-CC-000327

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000327).ps1 
#>

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription"

# Step 1: Ensure registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
    Write-Output "Created registry path: $regPath"
} else {
    Write-Output "Registry path exists: $regPath"
}

# Step 2: Enable PowerShell Transcription
New-ItemProperty -Path $regPath -Name "EnableTranscripting" -PropertyType DWORD -Value 1 -Force
Write-Output "Set EnableTranscripting to 1 (enabled)."

# Step 3: Configure Transcript Output Directory (adjust as needed)
# Recommended: UNC path to central log server (e.g., \\LogServer\PSLogs)
$logPath = "C:\PowerShellTranscripts"

# Ensure directory exists
if (-not (Test-Path $logPath)) {
    New-Item -Path $logPath -ItemType Directory -Force | Out-Null
    Write-Output "Created log directory: $logPath"
}

New-ItemProperty -Path $regPath -Name "OutputDirectory" -PropertyType String -Value $logPath -Force
Write-Output "Set OutputDirectory to $logPath."

# Step 4: Verify settings
Write-Output "`nVerifying registry settings..."
Get-ItemProperty -Path $regPath | Format-List

Write-Output "`nPowerShell Transcription remediation completed."
