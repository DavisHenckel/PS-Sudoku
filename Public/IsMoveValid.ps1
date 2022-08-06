<#
.SYNOPSIS
    Determines if a sudoku move is valid
.DESCRIPTION
    Accounts for all 3 possible scenarios where a move could be invalid
.PARAMETER SudokuGrid
    The current Sudoku grid
.PARAMETER Row
    The row of the placement to attempt, this must be in the range 1-9
.PARAMETER Column
    The column of the placement to attempt, this must be in the range 1-9
.PARAMETER Number
    The number to be tried, this must be in the range 1-9
.EXAMPLE
    IsMoveValid -SudokuGrid SudokuGrid -Row 1 -Column 1 -Number 1
.INPUTS
    Takes in a Sudoku grid, a row, a column, and a number
.OUTPUTS
    Returns a boolean value indicating if the move is valid
#>
Function IsMoveValid {
    Param (
        [parameter(Mandatory=$true)]
        [System.Object]$SudokuGrid,
        [parameter(Mandatory=$true)]
        [ValidateRange(1,9)]
        [int32]$Row,
        [parameter(Mandatory=$true)]
        [ValidateRange(1,9)]
        [int32]$Column,
        [parameter(Mandatory=$true)]
        [ValidateRange(1,9)]
        [int32]$Number
    )
    If (IsRowPlacementValid -SudokuGrid $SudokuGrid -Row $Row -Number $Number) {
        If (IsColumnPlacementValid -SudokuGrid $SudokuGrid -Column $Column -Number $Number) {
            If (IsSubGridPlacementValid -SudokuGrid $SudokuGrid -Row $Row -Column $Column -Number $Number) {
                Return $true
            }
        }
    }
    Return $false
}
