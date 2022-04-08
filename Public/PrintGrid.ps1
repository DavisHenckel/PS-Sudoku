<#
.SYNOPSIS
    Prints a Sudoku grid
.DESCRIPTION
    Prints the current state of the Sudoku grid.
.PARAMETER SudokuGrid
    The 2D array representing the Sudoku grid.
.EXAMPLE
    PrintGrid -Grid $SudokuGrid
.INPUTS
    Takes in a Sudoku grid
.OUTPUTS
    Does not return anything. Simply outputs the Sudoku Board to the console
#>
Function PrintGrid {
    param (
        [parameter(Mandatory=$true,ValueFromPipeline=$false)]
        [System.Object]$SudokuGrid
    )
    $Iterator = 1
    $RowIterator = 1
    Write-Output "+++++++++++++++++++++++++" -ForegroundColor Green
    ForEach ($Element in $SudokuGrid) {
        if ($RowIterator % 4 -eq 0) {
            Write-Output "|-------+-------+------ |" -ForegroundColor Green
            $RowIterator = 1
        }
        Write-Output "| " -NoNewLine -ForegroundColor Green
        $RowIterator += 1
        ForEach ($Item in $Element) {
            Write-Output "$Item " -NoNewline
            if ($Iterator -eq 9) {
                Write-Output "|" -ForegroundColor Green
                $Iterator = 1
                continue
            }
            if ($Iterator % 3 -eq 0) {
                Write-Output "| " -ForegroundColor Green -NoNewline
            }
            $Iterator += 1
        }
    }
    Write-Output "+++++++++++++++++++++++++" -ForegroundColor Green
    Write-Output "`n"
}