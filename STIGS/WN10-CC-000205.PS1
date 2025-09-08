<#
.SYNOPSIS
    Configures Windows telemetry level to the lowest allowed 
    (0 = Security for Enterprise/Education, 1 = Basic for others).

.NOTES
    Author          : Rayan Abu Omar 
    LinkedIn        : linkedin.com/in/rayan-abu-omar/
    GitHub          : github.com/rayanabuomar
    Date Created    : 19-08-2025
    Last Modified   : 19-08-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000205

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000205).ps1 
#>

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
    Write-Output "Created registry path: $regPath"
}

# Detect edition (Enterprise/Education can use 0 = Security)
$editionId = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name EditionID).EditionID
$enterpriseLike = @("Enterprise","EnterpriseN","EnterpriseS","EnterpriseSN","Education","EducationN") -contains $editionId

# Choose compliant value
$desired = if ($enterpriseLike) { 0 } else { 1 }  # 0=Security, 1=Basic

New-ItemProperty -Path $regPath -Name "AllowTelemetry" -PropertyType DWord -Value $desired -Force | Out-Null
Write-Output "Set AllowTelemetry to $desired under $regPath (Edition: $editionId)."

# Verify
Write-Output "`nVerifying..."
(Get-ItemProperty -Path $regPath -Name AllowTelemetry).AllowTelemetry | ForEach-Object {
    Write-Output "AllowTelemetry = $_ (0=Security, 1=Basic, 2=Enhanced, 3=Full)"
}

Write-Output "`nTelemetry remediation complete. A reboot or policy refresh may be needed for services to pick up the change."
