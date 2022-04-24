<#
.SYNOPSIS
    Solves a Sudoku puzzle
.DESCRIPTION
    Completes the Sudoku Puzzle if there is any solution by recursively calling itself until completion.
.PARAMETER SudokuGrid
    The current state Sudoku grid, this is modified on each call.
.PARAMETER WatchAlg
    A boolean to indicate whether to use print statements at each call to watch the algorithm in action.
.PARAMETER StopWatch
    A timer that tracks how long the algorithm has been running. If it takes longer than 60 seconds, return false and retry. TODO to fix this if possible.
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
        [System.Object]$SudokuGrid,
        [parameter(Mandatory=$false)]
        [bool]$WatchAlg = $false,
        [parameter(Mandatory=$false)]
        $StopWatch = $null
    )
    if ($StopWatch) {
        if($StopWatch.Elapsed.seconds -ge 10) {
            return $false
        }
    }
    $EmptyMove = FindEmptySpot -SudokuGrid $SudokuGrid
    if (-not $EmptyMove) {
        return $true #puzzle is solved
    }
    For ($i = 1; $i -lt 10; $i++) {
        $Row = $EmptyMove.Item1
        $Column = $EmptyMove.Item2
        if (IsMoveValid -SudokuGrid $SudokuGrid -Row $Row -Column $Column -Number $i) {
            $SudokuGrid[$Row-1][$Column-1] = $i
            if ($WatchAlg) {
                Write-Host "Placing $i at $Row, $Column" -ForegroundColor Green
                PrintGrid -SudokuGrid $SudokuGrid
                Start-Sleep 1
            }
            if (SolveSudoku -SudokuGrid $SudokuGrid -WatchAlg $WatchAlg -StopWatch $StopWatch) { #attempt to solve the rest of the puzzle with the new number
                return $true
            }
            if ($WatchAlg) {
                Write-Host "Backtracking..." -ForegroundColor Yellow
            }
            #if the number can't be placed because there is no solution on future calls, remove it from the grid
            $SudokuGrid[$Row-1][$Column-1] = 0
        }
    }
    return $false #puzzle can't be solved
}
