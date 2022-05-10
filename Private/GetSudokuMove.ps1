<#
.SYNOPSIS
    Gets a user's number placement.
.DESCRIPTION
    Gets a user's number placement after validating the move is valid given the current state of the board.
.PARAMETER SudokuGrid   
    The current state of the Sudoku Grid.
.EXAMPLE
    $SudokuPlay = GetSudokuMove -SudokuGrid $Grid
.INPUTS
    Takes in a Sudoku Board
.OUTPUTS
    Returns a 2d Tuple, with [0] being the number to place and [1] being the row, column to place at.
#>