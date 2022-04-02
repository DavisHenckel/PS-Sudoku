<#
.SYNOPSIS
    Determines whether the current number exists in a subgrid
.DESCRIPTION
    Determines whether the current number exists in a subgrid. The subgrid is a 3x3 2d array. 
.PARAMETER XRangeLower
    The low range of x coordinates of the subgrid
.PARAMETER XRangeUpper
    The high range of x coordinates of the subgrid
.PARAMETER YRangeLower
    The low range of y coordinates of the subgrid
.PARAMETER YRangeUpper
    The high range of y coordinates of the subgrid
.PARAMETER Number
    The number to check for
.PARAMETER SudokuGrid
    The sudoku grid to check in
.EXAMPLE
    NumberInSubgrid -XRagneLower 0 -XRangeUpper 2 -YRangeLower 0 -YRangeUpper 2 -Number 1 -SudokuGrid $Grid
.INPUTS
    x and y range, with a grid and a number
.OUTPUTS
    Returns a boolean that defines whether the number exists or not in the subgrid
#>
Function NumberInSubgrid {
    param (
        [parameter(Mandatory=$true)]
        [int32]$XRangeLower,
        [parameter(Mandatory=$true)]
        [int32]$XRangeUpper,
        [parameter(Mandatory=$true)]
        [int32]$YRangeLower,
        [parameter(Mandatory=$true)]
        [int32]$YRangeUpper,
        [parameter(Mandatory=$true)]
        [System.Object]$SudokuGrid,
        [parameter(Mandatory=$true)]
        [int32]$Number
    )
    For ($i = $XRangeLower; $i -lt $XRangeUpper; $i++) {
        For ($j = $YRangeLower; $j -lt $YRangeUpper; $j++) {
            if ($SudokuGrid[$i][$j] -eq $Number) {
                return $false
            }
        }
    }
    return $true
}