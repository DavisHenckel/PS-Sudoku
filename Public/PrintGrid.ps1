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
    Param (
        [parameter(Mandatory=$true,ValueFromPipeline=$false)]
        [System.Object]$SudokuGrid
    )
    $Iterator = 1
    $RowIterator = 1
    $OutputString = "+++++++++++++++++++++++++`n"
    ForEach ($Element in $SudokuGrid) {
        If ($RowIterator % 4 -eq 0) {
            $OutputString += "|-------+-------+------ |`n" 
            $RowIterator = 1
        }
        $OutputString += "| "
        $RowIterator += 1
        ForEach ($Item in $Element) {
            $OutputString += "$Item "
            If ($Iterator -eq 9) {
                $OutputString += "|`n"
                $Iterator = 1
                Continue
            }
            If ($Iterator % 3 -eq 0) {
                $OutputString += "| "
            }
            $Iterator += 1
        }
    }
    $OutputString += "+++++++++++++++++++++++++`n"
    Return $OutputString
}
