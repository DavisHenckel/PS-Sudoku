<#
.SYNOPSIS
    Generates an Empty 2D Arraylist
.DESCRIPTION
    Generates an Empty 2D Arraylist that will be used for the Sudoku Board
.EXAMPLE
    $SudokuBoard = GenerateGrid
.OUTPUTS
    Returns a 2D arraylist
#>
Function GenerateGrid {
    param(
        [parameter(Mandatory=$false)]
        [ValidateSet("Empty", "Easy", "Medium", "Hard", "Insane", "Filled")]
        [String]$Difficulty = "Empty"
    )
    if ($Difficulty -eq "Empty") {
        return [System.Array]@(
            [System.Array]@(0,0,0,0,0,0,0,0,0),
            [System.Array]@(0,0,0,0,0,0,0,0,0),
            [System.Array]@(0,0,0,0,0,0,0,0,0),
            [System.Array]@(0,0,0,0,0,0,0,0,0),
            [System.Array]@(0,0,0,0,0,0,0,0,0),
            [System.Array]@(0,0,0,0,0,0,0,0,0),
            [System.Array]@(0,0,0,0,0,0,0,0,0),
            [System.Array]@(0,0,0,0,0,0,0,0,0),
            [System.Array]@(0,0,0,0,0,0,0,0,0)
        )
    }
    if ($Difficulty -eq "Easy") {
        return [System.Array]@(
            [System.Array]@(0,0,4,0,5,0,0,0,0),
            [System.Array]@(9,0,0,7,3,4,6,0,0),
            [System.Array]@(0,0,3,0,2,1,0,4,9),
            [System.Array]@(0,3,5,0,9,0,4,8,0),
            [System.Array]@(0,9,0,0,0,0,0,3,0),
            [System.Array]@(0,7,6,0,1,0,9,2,0),
            [System.Array]@(3,1,0,9,7,0,2,0,0),
            [System.Array]@(0,0,9,1,8,2,0,0,3),
            [System.Array]@(0,0,0,0,6,0,1,0,0)
        )
    }
    if ($Difficulty -eq "Medium") {
        return [System.Array]@(
            [System.Array]@(0,0,0,9,0,5,0,6,0),
            [System.Array]@(1,6,0,0,0,8,0,0,0),
            [System.Array]@(0,0,0,0,4,0,0,1,3),
            [System.Array]@(0,2,0,5,0,0,8,0,0),
            [System.Array]@(7,3,9,0,8,0,0,4,5),
            [System.Array]@(0,0,8,0,0,0,2,0,9),
            [System.Array]@(3,0,0,0,7,0,0,2,0),
            [System.Array]@(0,8,2,4,5,0,3,0,7),
            [System.Array]@(9,5,0,0,0,0,0,8,0)
        )
    }
    if ($Difficulty -eq "Filled") {
        return [System.Array]@(
            [System.Array]@(1,1,1,1,1,1,1,1,1),
            [System.Array]@(1,1,1,1,1,1,1,1,1),
            [System.Array]@(1,1,1,1,1,1,1,1,1),
            [System.Array]@(1,1,1,1,1,1,1,1,1),
            [System.Array]@(1,1,1,1,1,1,1,1,1),
            [System.Array]@(1,1,1,1,1,1,1,1,1),
            [System.Array]@(1,1,1,1,1,1,1,1,1),
            [System.Array]@(1,1,1,1,1,1,1,1,1),
            [System.Array]@(1,1,1,1,1,1,1,1,1)
        )
    }

}
