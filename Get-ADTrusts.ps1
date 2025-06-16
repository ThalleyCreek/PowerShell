function Get-ADTrusts {
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
        Get-ADTrust -Filter * -Server $Target -Credential $Credential | Select-Object Name, Direction, ForestTransitive, Target, Source
    }
    catch [Microsoft.ActiveDirectory.Management.ADServerDownException] {
        Write-Error "Cannot contact '$Target'. It may be unreachable, missing ADWS, or credentials may be invalid."
    }
    catch {
        Write-Error "Unexpected error querying '$Target': $_"
    }
}
