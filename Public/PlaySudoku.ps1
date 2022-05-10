<#
.SYNOPSIS
    Function to play Sudoku
.DESCRIPTION
    Allows a player to play a sudoku game given any sudoku board.
.PARAMETER SudokuGrid
    The SudokuGrid
.EXAMPLE
    PlaySudoku -SudokuGrid $Grid
.INPUTS
    Takes in a Sudoku grid
.OUTPUTS
    TODO
#>
Function PlaySudoku {
    param (
        [parameter(Mandatory=$true)]
        [System.Object]$SudokuGrid
    )
}