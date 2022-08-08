<#
.SYNOPSIS
    Determines if a number placement is valid
.DESCRIPTION
    Based on row and number, determines if the placement is valid.
.PARAMETER SudokuGrid
    A 2D array representing the Sudoku grid
.PARAMETER Row
    The row of the placement to attempt, this must be in the range 1-9
.PARAMETER Number
    The number to be tried, must be in the range 1-9
.EXAMPLE
    IsRowValidPlacement (Grid, 1, 1) #where 1, 1 is the row and number
.INPUTS
    Takes in a Sudoku grid, a row, and a number
.OUTPUTS
    Returns a boolean
#>
Function IsRowPlacementValid {
    param (
        [parameter(Mandatory=$true)]
        [System.Object]$SudokuGrid,
        [parameter(Mandatory=$true)]
        [ValidateRange(1, 9)]
        [int32]$Row,
        [parameter(Mandatory=$true)]
        [ValidateRange(1, 9)]
        [int32]$Number
    )
    $SelectedRow = $SudokuGrid[$Row - 1]
    if (($SelectedRow.Contains($Number)) -or ($SelectedRow.Contains([string]$Number))) {
        return $false
    }
    else {
        return $true
    }
}