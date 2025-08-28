function Get-SystemUptime {
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
        Since   = $OS.LastBootUpTime
    }
}
