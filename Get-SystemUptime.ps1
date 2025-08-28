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
    $OS = Get-CimInstance Win32_OperatingSystem
    $UpTime = (Get-Date) - $OS.LastBootUpTime
    [PSCustomObject]@{
        Days    = $UpTime.Days
        Hours   = $UpTime.Hours
        Minutes = $UpTime.Minutes
        LastBootUpTime = $OS.LastBootUpTime
    }
}
