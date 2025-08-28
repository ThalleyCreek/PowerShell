<#
.SYNOPSIS
Gets the time elapsed since the last system boot.

.DESCRIPTION
Retrieves the operating system's last boot time and calculates the days,
hours, and minutes the system has been running.

.EXAMPLE
PS> Get-SystemUptime
Returns an object showing the current system uptime and last boot time.

.OUTPUTS
PSCustomObject. Returns an object with Days, Hours, Minutes, and Since properties.
#>
function Get-SystemUptime {

    <#
    .SYNOPSIS
        Returns system uptime information including the last boot time.

    .EXAMPLE
        PS> Get-SystemUptime

        Days Hours Minutes LastBootUpTime
        ---- ----- ------- --------------
        5    3     20      10/19/2023 08:42:00
    #>

    [CmdletBinding()]
    param(
        [string[]]$ComputerName,
        [Microsoft.Management.Infrastructure.CimSession[]]$CimSession
    )

    $OS = Get-CimInstance Win32_OperatingSystem
    $UpTime = (Get-Date) - $OS.LastBootUpTime
    [PSCustomObject]@{
        Days    = $UpTime.Days
        Hours   = $UpTime.Hours
        Minutes = $UpTime.Minutes
        LastBootUpTime = $OS.LastBootUpTime
    }
}
