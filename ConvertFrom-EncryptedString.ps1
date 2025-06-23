function ConvertFrom-EncryptedString {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$KeyPath,

        [Parameter(Mandatory)]
        [string]$EncryptedPasswordPath
    )

    $Key = Get-Content -Path $KeyPath
    $SecurePassword = Get-Content -Path $EncryptedPasswordPath | ConvertTo-SecureString -Key $Key

    $BSTR = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword)
    try {
        return [Runtime.InteropServices.Marshal]::PtrToStringBSTR($BSTR)
    }
    finally {
        [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
    }
}
