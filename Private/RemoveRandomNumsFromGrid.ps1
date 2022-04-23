<#
.SYNOPSIS
    Removes numbers from the Sudoku grid.
.DESCRIPTION
    Removes numbers from Sudoku grid by initializing numbers to 0. This function is called by the FindValidSudokuGrid function. 
    This function is kept private because it will only be used by the FindValidSudokuGrid function.
.PARAMETER SolvedGrid   
    A fully solved Sudoku grid
.PARAMETER NumClues   
    The number of clues to leave remaining on the Sudoku grid.
.EXAMPLE
    $SudokuGrid = RemoveNumbersFromSudokuGrid -SolvedGrid $Grid -NumClues $NumClues
.INPUTS
    Takes in a fully solved Sudoku grid and a number of clues
.OUTPUTS
    Returns a Sudoku grid with the specified number of clues remaining
#>
Function RemoveRandomNumsFromGrid {
    param(
        [parameter(Mandatory=$true)]
        [System.Object]$SolvedGrid,
        [parameter(Mandatory=$true)]
        [System.Object]$NumClues
    )
    $ReturnGrid = DeepCopyArray $SolvedGrid
    $RemovedNumbers = 0
    while ($RemovedNumbers -lt 81-$NumClues) {
        $Ctr = 0
        $LocToRemove = Get-Random -Minimum 0 -Maximum 80
        :middleloop for ($j = 0; $j -lt 9; $j++) {
            for ($k = 0; $k -lt 9; $k++) {
                if ($LocToRemove -eq $Ctr) {
                    if ($ReturnGrid[$j][$k] -ne 0) {
                        $ReturnGrid[$j][$k] = 0 #erase the number
                        $RemovedNumbers += 1
                    }
                    break middleloop #break out of the inner loop since we found the location. Move onto the next number
                }
                $Ctr++
            }
        }
    }
    return $ReturnGrid
}