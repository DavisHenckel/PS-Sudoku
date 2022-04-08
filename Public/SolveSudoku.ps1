<#
.SYNOPSIS
    Solves a Sudoku puzzle
.DESCRIPTION
    Completes the Sudoku Puzzle if there is any solution by recursively calling itself until completion.
.PARAMETER SudokuGrid
    The current state Sudoku grid, this is modified on each call.
.EXAMPLE
    SolveSudoku -SudokuGrid $SudokuGrid
.INPUTS
    Takes in a Sudoku grid.
.OUTPUTS
    Outputs a boolean value indicating whether the Sudoku grid is solved or not.
#>
Function SolveSudoku {
    param (
        [parameter(Mandatory=$true)]
        [System.Object]$SudokuGrid
    )
    $EmptyMove = FindEmptySpot -SudokuGrid $SudokuGrid
    if (-not $EmptyMove) {
        return $true #puzzle is solved
    }
    else {
        For ($i = 1; $i -lt 10; $i++) {
            $Row = $EmptyMove.Item1
            $Column = $EmptyMove.Item2
            if (IsMoveValid -SudokuGrid $SudokuGrid -Row $Row -Column $Column -Number $i) {
                $SudokuGrid[$Row-1][$Column-1] = $i
                if (SolveSudoku -SudokuGrid $SudokuGrid) { #attempt to solve the rest of the puzzle with the new number
                    return $true
                }
                #if the number can't be placed because there is no solution on future calls, remove it from the grid
                $SudokuGrid[$Row-1][$Column-1] = 0
            }
        }
        return $false #puzzle can't be solved
    }
}