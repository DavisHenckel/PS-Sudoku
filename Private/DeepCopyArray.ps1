<#
.SYNOPSIS
    Copies an array by value instead of reference
.DESCRIPTION
    Copies the array contents by serializing as bytes and then deserializing.
.PARAMETER Source   
    The array to copy.
.EXAMPLE
    $DestinationArray = DeepCopyArray $SourceArray
.INPUTS
    Takes in an array.
.OUTPUTS
    Returns a copied array by value.
#>
Function DeepCopyArray ($Source) {
    # This function is used only here to copy an array by value. PS uses reference by default but I do not want that behavior here.
    # https://stackoverflow.com/questions/29699026/powershell-copy-an-array-completely
    $reader = New-Object System.IO.MemoryStream
    $Bytes = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
    $Bytes.Serialize($reader, $Source)
    $reader.Position = 0
    $Dest = $Bytes.Deserialize($reader)
    $reader.Close()
    return $Dest
}