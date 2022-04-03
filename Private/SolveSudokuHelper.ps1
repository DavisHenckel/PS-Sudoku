Function SolveSudokuHelper {
    param (
        [parameter(Mandatory=$true)]
        [System.Object]$SudokuGrid
    )
    $EmptyMove = FindEmptySpot -SudokuGrid $SudokuGrid
    if (-not $EmptyMove) {
        PrintGrid -SudokuGrid $SudokuGrid
        Write-Host "Congratulations, the Sudoku puzzle has been solved!" -ForegroundColor Green
        pause
        return $true
    }
    else {
        For ($i = 1; $i -lt 10; $i++) {
            $EmptyMove = FindEmptySpot -SudokuGrid $SudokuGrid
            $Row = $EmptyMove.Item1
            $Column = $EmptyMove.Item2
            if (IsMoveValid -SudokuGrid $SudokuGrid -Row $Row -Column $Column -Number $i) {
                $SudokuGrid[$Row-1][$Column-1] = $i
                PrintGrid -SudokuGrid $SudokuGrid
                SolveSudokuHelper -SudokuGrid $SudokuGrid #recurse through the grid, passsing the modified grid
            }
            else { #if the number can't be placed, remove it from the grid
                $SudokuGrid[$Row-1][$Column-1] = 0
            }
        }
    }
}

