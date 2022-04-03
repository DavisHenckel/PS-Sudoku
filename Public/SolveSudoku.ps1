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
    Prints the state of the puzzle on each call. Prints success message when completed and returns $true.
#>
Function SolveSudoku {
    param (
        [parameter(Mandatory=$true)]
        [System.Object]$SudokuGrid,
        [parameter(Mandatory=$false)]
        [bool]$PrintSolution = $true
    )
    $EmptyMove = FindEmptySpot -SudokuGrid $SudokuGrid
    if (-not $EmptyMove) {
        if ($PrintSolution) {
            PrintGrid -SudokuGrid $SudokuGrid
        }
        Write-Host "The Sudoku puzzle has been solved!" -ForegroundColor Green
        return
    }
    else {
        For ($i = 1; $i -lt 10; $i++) {
            $Row = $EmptyMove.Item1
            $Column = $EmptyMove.Item2
            if (IsMoveValid -SudokuGrid $SudokuGrid -Row $Row -Column $Column -Number $i) {
                $SudokuGrid[$Row-1][$Column-1] = $i
                SolveSudoku -SudokuGrid $SudokuGrid #recurse through the grid, passsing the modified grid
            }
            else { #if the number can't be placed, remove it from the grid
                if (IsGameFinished -SudokuGrid $SudokuGrid) {
                    return
                }
                $SudokuGrid[$Row-1][$Column-1] = 0
            }
        }
    }
}