    <#
    .SYNOPSIS
        Generates an Empty 2D Arraylist
    .DESCRIPTION
        Generates an Empty 2D Arraylist that will be used for the Sudoku Board
    .EXAMPLE
        $SudokuBoard = GenerateEmptyGrid
    .OUTPUTS
        Returns a 2D arraylist
    #>
    Function GenerateEmptyGrid {
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
