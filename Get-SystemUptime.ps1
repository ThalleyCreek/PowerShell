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
    $OS = Get-CimInstance Win32_OperatingSystem
    $UpTime = (Get-Date) - $OS.LastBootUpTime

    [PSCustomObject]@{
        Days    = $UpTime.Days
        Hours   = $UpTime.Hours
        Minutes = $UpTime.Minutes
        Since   = $OS.LastBootUpTime
    }
}
