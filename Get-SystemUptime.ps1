function Get-SystemUptime {
    $OS = Get-CimInstance -ClassName Win32_OperatingSystem -Property LastBootUpTime
    $UpTime = (Get-Date) - $OS.LastBootUpTime

    [PSCustomObject]@{
        Days    = $UpTime.Days
        Hours   = $UpTime.Hours
        Minutes = $UpTime.Minutes
        Since   = $OS.LastBootUpTime
    }
}
