function Get-ADDomainControllers {
    [CmdletBinding(DefaultParameterSetName = 'Domain')]
    param (
        [Parameter(ParameterSetName = 'Domain', Mandatory = $true)]
        [string]$Domain,

        [Parameter(ParameterSetName = 'Server', Mandatory = $true)]
        [string]$Server,

        [PSCredential]$Credential = (Get-Credential)
    )

    $Target = switch ($PSCmdlet.ParameterSetName) {
        'Domain' { $Domain }
        'Server' { $Server }
    }

    try {
        Get-ADDomainController -Filter * -Server $Target -Credential $Credential | Select-Object Name, Domain, HostName, Forest, IPv4Address, Site, OperatingSystem, @{N='Pingable';E={Test-Connection -Ping -IPv4 -Count 2 -Quiet -TargetName $($_.HostName)}}
    }
    catch [Microsoft.ActiveDirectory.Management.ADServerDownException] {
        Write-Error "Cannot contact '$Target'. It may be unreachable, missing ADWS, or credentials may be invalid."
    }
    catch {
        Write-Error "Unexpected error querying '$Target': $_"
    }
}
