function Get-SystemUptime {
<#
.SYNOPSIS
    Returns system uptime and last boot time.

.DESCRIPTION
    Calculates days, hours, and minutes since the last system boot.

.EXAMPLE
    PS> Get-SystemUptime

.OUTPUTS
    PSCustomObject: Days, Hours, Minutes, LastBootUpTime
#>
    [CmdletBinding()]
    param(
        [string[]]$ComputerName,
        [Microsoft.Management.Infrastructure.CimSession[]]$CimSession
    )

    $cimParams = @{}
    if ($PSBoundParameters.ContainsKey('ComputerName')) { $cimParams['ComputerName'] = $ComputerName }
    if ($PSBoundParameters.ContainsKey('CimSession'))   { $cimParams['CimSession'] = $CimSession }

    try {
        $osInstances = Get-CimInstance @cimParams -ClassName Win32_OperatingSystem -ErrorAction Stop
    } catch {
        Write-Error "Failed to retrieve operating system information: $_"
        return
    }

    if (-not $osInstances) {
        Write-Error "No operating system instances found."
        return
    }

    foreach ($os in $osInstances) {
        if (-not $os.LastBootUpTime) {
            Write-Error "LastBootUpTime property not found for $($os.PSComputerName)."
            continue
        }
        $uptime = (Get-Date) - $os.LastBootUpTime
        [PSCustomObject]@{
            Days           = $uptime.Days
            Hours          = $uptime.Hours
            Minutes        = $uptime.Minutes
            LastBootUpTime = $os.LastBootUpTime
        }
    }
}
