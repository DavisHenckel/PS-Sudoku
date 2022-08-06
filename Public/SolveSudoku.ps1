<#
.SYNOPSIS
    Solves a Sudoku puzzle
.DESCRIPTION
    Completes the Sudoku Puzzle if there is any solution by recursively calling itself until completion.
.PARAMETER SudokuGrid
    The current state Sudoku grid, this is modified on each call.
.PARAMETER WatchAglorithm
    A switch to indicate whether to use print statements at each call to watch the algorithm in action.
.PARAMETER StopWatch
    A timer that tracks how long the algorithm has been running. If it takes longer than 60 seconds, return false.
.EXAMPLE
    SolveSudoku -SudokuGrid $SudokuGrid
.INPUTS
    Takes in a Sudoku grid.
.OUTPUTS
    Outputs a boolean value indicating whether the Sudoku grid is solved or not.
#>
Function SolveSudoku {
    Param (
        [parameter(Mandatory=$true)]
        [System.Object]$SudokuGrid,
        [parameter(Mandatory=$false)]
        [switch]$WatchAlgorithm,
        [parameter(Mandatory=$false)]
        $StopWatch = $null
    )
    If ($StopWatch) {
        If($StopWatch.Elapsed.seconds -ge 20) {
            Return $false
        }
    }
    If ($WatchAlgorithm) {
        $EmptyMove = FindEmptySpot -SudokuGrid $SudokuGrid
        If (-not $EmptyMove) {
            Return $true #puzzle is solved   
        }
        $Row = $EmptyMove.Item1
        $Column = $EmptyMove.Item2
        For ($i = 1; $i -lt 10; $i++) {
            If (IsMoveValid -SudokuGrid $SudokuGrid -Row $Row -Column $Column -Number $i) {
                $SudokuGrid[$Row-1][$Column-1] = $i
                Write-Host ("Placing $i at $Row, $Column")
                Write-Host (PrintGrid -SudokuGrid $SudokuGrid)
                Start-Sleep 0.1
                If (SolveSudoku -SudokuGrid $SudokuGrid -WatchAlgorithm -StopWatch $StopWatch) { #attempt to solve the rest of the puzzle with the new number
                    Return $true
                }
                Write-Host "Backtracking..."
            }
            #if the number can't be placed because there is no solution on future calls, remove it from the grid
            $SudokuGrid[$Row-1][$Column-1] = '-'
        }
        Return $false #puzzle can't be solved
    }
    Else {
        $EmptyMove = FindEmptySpot -SudokuGrid $SudokuGrid
        If (-not $EmptyMove) {
            Return $true #puzzle is solved
        }
        $Row = $EmptyMove.Item1
        $Column = $EmptyMove.Item2
        For ($i = 1; $i -lt 10; $i++) {
            If (IsMoveValid -SudokuGrid $SudokuGrid -Row $Row -Column $Column -Number $i) {
                $SudokuGrid[$Row-1][$Column-1] = $i
                If (SolveSudoku -SudokuGrid $SudokuGrid -StopWatch $StopWatch) { #attempt to solve the rest of the puzzle with the new number
                    Return $true
                }
            }
            #if the number can't be placed because there is no solution on future calls, remove it from the grid
            $SudokuGrid[$Row-1][$Column-1] = '-'
        }
        Return $false #puzzle can't be solved
    }
}
