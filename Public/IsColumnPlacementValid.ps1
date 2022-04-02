<#
.SYNOPSIS
    Determines if a number placement is valid
.DESCRIPTION
    Based on column and number, determines if the placement is valid.
.PARAMETER SudokuGrid
    The current Sudoku grid
.PARAMETER Column
    The column of the placement to attempt, this must be in the range 1-9
.PARAMETER Number
    The number to be tried, this must be in the range 1-9
.EXAMPLE
    IsColumnValidPlacement(Grid, 1, 1) #where 1, 1 is the column and number
.INPUTS
    Takes in a Sudoku grid, a column, and a number
.OUTPUTS
    Returns a boolean
#>
Function IsColumnPlacementValid {
    param (
        [parameter(Mandatory=$true)]
        [System.Object]$SudokuGrid,
        [parameter(Mandatory=$true)]
        [ValidateRange(1, 9)]
        [int32]$Column,
        [parameter(Mandatory=$true)]
        [ValidateRange(1, 9)]
        [int32]$Number
    )
    ForEach ($Row in $SudokuGrid) {
        if ($Row[$Column - 1] -eq $Number) {
            return $false
        }
    }
    return $true
}