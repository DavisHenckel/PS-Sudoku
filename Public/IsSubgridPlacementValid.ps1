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
    param (
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
    switch (CalculateSubgridNumber -Row $Row -Column $Column) {
        0{
            return NumberInSubgrid -XRangeLower 0 -XRangeUpper 3 -YRangeLower 0 -YRangeUpper 3 -SudokuGrid $SudokuGrid -Number $Number
        }
        1{
            return NumberInSubgrid -XRangeLower 0 -XRangeUpper 3 -YRangeLower 3 -YRangeUpper 6 -SudokuGrid $SudokuGrid -Number $Number
        }
        2{
            return NumberInSubgrid -XRangeLower 0 -XRangeUpper 3 -YRangeLower 6 -YRangeUpper 9 -SudokuGrid $SudokuGrid -Number $Number
        }
        3{
            return NumberInSubgrid -XRangeLower 3 -XRangeUpper 6 -YRangeLower 0 -YRangeUpper 3 -SudokuGrid $SudokuGrid -Number $Number
        }
        4{
            return NumberInSubgrid -XRangeLower 3 -XRangeUpper 6 -YRangeLower 3 -YRangeUpper 6 -SudokuGrid $SudokuGrid -Number $Number
        }
        5{
            return NumberInSubgrid -XRangeLower 3 -XRangeUpper 6 -YRangeLower 6 -YRangeUpper 9 -SudokuGrid $SudokuGrid -Number $Number
        }
        6{
            return NumberInSubgrid -XRangeLower 6 -XRangeUpper 9 -YRangeLower 0 -YRangeUpper 3 -SudokuGrid $SudokuGrid -Number $Number
        }
        7{
            return NumberInSubgrid -XRangeLower 6 -XRangeUpper 9 -YRangeLower 3 -YRangeUpper 6 -SudokuGrid $SudokuGrid -Number $Number
        }
        8{
            return NumberInSubgrid -XRangeLower 6 -XRangeUpper 9 -YRangeLower 6 -YRangeUpper 9 -SudokuGrid $SudokuGrid -Number $Number
        }
        default {
            Write-Error "Invalid subgrid"
            Return $null
        }
    }
}
