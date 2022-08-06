<#
.SYNOPSIS
    Determines if a number placement is valid
.DESCRIPTION
    Based on a subgrid defined by row and column, determines if the number placement is valid.
.PARAMETER SudokuGrid
    A 2D array representing the Sudoku grid
.PARAMETER Row
    The row of the placement to attempt, this must be in the range 1-9
.PARAMETER Column
    The column of the placement to attempt, this must be in the range 1-9
.PARAMETER Number
    The number to be tried, must be in the range 1-9
.EXAMPLE
    IsSubGridValidPlacement -SudokuGrid $Grid -Row 1 -Column 1 -Number 2
.INPUTS
    Takes in a Sudoku grid, a row, a column, and a number
.OUTPUTS
    Returns a boolean
#>
Function IsSubgridPlacementValid {
    Param (
        [parameter(Mandatory=$true)]
        [System.Object]$SudokuGrid,
        [parameter(Mandatory=$true)]
        [ValidateRange(1, 9)]
        [int32]$Row,
        [parameter(Mandatory=$true)]
        [ValidateRange(1, 9)]
        [int32]$Column,
        [parameter(Mandatory=$true)]
        [ValidateRange(1, 9)]
        [int32]$Number
    )
    $CalcRow = $Row - 1
    $CalcCol = $Column - 1 
    [int32]$SubgridRowStart = [Math]::Floor(($CalcRow / 3)) * 3 
    [int32]$SubgridColumnStart = [Math]::Floor(($CalcCol / 3)) * 3
    For ($i = $SubgridRowStart; $i -lt $SubgridRowStart + 3; $i++) {
        For ($j = $SubgridColumnStart; $j -lt $SubgridColumnStart + 3; $j++) {
            If (($SudokuGrid[($i)][($j)] -eq $Number) -or ($SudokuGrid[($i)][($j)] -eq [string]$Number)) {
                Return $false
            }
        }
    }
    Return $true
}
