<#
.SYNOPSIS
    Finds an available spot to play a number
.DESCRIPTION
    Iterates through the entire sudoku board until a spot is found to play.
.PARAMETER SudokuGrid
    The current Sudoku grid
.EXAMPLE
    FindEmptySpot -SudokuGrid $SudokuGrid
.INPUTS
    Takes in a Sudoku grid.
.OUTPUTS
    Returns a tuple that contains the row and column of the empty spot. If there is no empty spot available, returns $null
#>
Function FindEmptySpot {
    param(
        [parameter(Mandatory=$true)]
        [System.Object]$SudokuGrid
    )
    
    for ($i = 0; $i -lt 9; $i++) {
        for($j = 0; $j -lt 9; $j++) {
            if ($SudokuGrid[$i][$j] -match '[^1-9]') {
                return [System.Tuple]::Create(($i+1),($j+1))
            }
        }
    }
    return $null
}
