<#
.SYNOPSIS
    Determines if a number placement is valid
.DESCRIPTION
    Based on row and number, determines if the placement is valid.
.EXAMPLE
    IsValidPlacement(Grid, 1, 1) #where 1, 1 is the row and number
.INPUTS
    Takes in a Sudoku grid, a row, a column, and a number
.OUTPUTS
    Returns a boolean
#>
Function IsRowPlacementValid {
    param (
        [parameter(Mandatory=$true)]
        [System.Object]$SudokuGrid,
        [parameter(Mandatory=$true)]
        [int32]$Row,
        [parameter(Mandatory=$true)]
        [int32]$Number
    )
    $SelectedRow = $SudokuGrid[$Row]
    if ($SelectedRow.Contains($Number)) {
        return $false
    }
    else {
        return $true
    }
}