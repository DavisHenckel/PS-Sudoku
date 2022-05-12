$DIFFICULTYCLUES = @{
    "Easy" = 37;
    "Medium" = 30;
    "Hard" = 23;
    "Expert" = 20;
    "Insane" = 17;
}

<#
.SYNOPSIS
    Generates a 2D Arraylist that represents the Sudoku board.
.DESCRIPTION
    By Default, will generate an Empty 2D array that will be used for the Sudoku Board. Allows for optional parameters that will give the user the ability to generate a Sudoku Board with a specified difficulty.
.PARAMETER Difficulty
    The difficulty of the Sudoku Board. This must be in the set "Filled", "Empty", "Easy", "Medium", "Hard", "Expert", or "Insane" where easy-insane is 37,3'-',23,2'-',17 number of clues respectively
    Empty is the default and will generate an empty board of all '-'.
.EXAMPLE
    $SudokuBoard = GenerateGrid
.EXAMPLE
    $SudokuBoard = GenerateGrid -Difficulty "Easy" #will provide 37 random clues
.EXAMPLE 
    $SudokuBoard = GenerateGrid -Difficulty "Medium" #will provide 30 random clues
.EXAMPLE 
    $SudokuBoard = GenerateGrid -Difficulty "Hard" #will provide 23 random clues
.EXAMPLE 
    $SudokuBoard = GenerateGrid -Difficulty "Expert" #will provide 20 random clues
.EXAMPLE 
    $SudokuBoard = GenerateGrid -Difficulty "Insane" #will provide 17 random clues
.OUTPUTS
    Returns a 2D array that is the Sudoku Board. 
#>
Function GenerateGrid {
    param(
        [parameter(Mandatory=$false)]
        [ValidateSet("Empty", "Easy", "Medium", "Hard", "Expert", "Insane", "Filled", "UniqueSolution")]
        [String]$Difficulty = "Empty"
    )
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
    $StarterArr = [System.Array]@(
        [System.Array]@('-','-','-','-','-','-','-','-','-'),
        [System.Array]@('-','-','-','-','-','-','-','-','-'),
        [System.Array]@('-','-','-','-','-','-','-','-','-'),
        [System.Array]@('-','-','-','-','-','-','-','-','-'),
        [System.Array]@('-','-','-','-','-','-','-','-','-'),
        [System.Array]@('-','-','-','-','-','-','-','-','-'),
        [System.Array]@('-','-','-','-','-','-','-','-','-'),
        [System.Array]@('-','-','-','-','-','-','-','-','-'),
        [System.Array]@('-','-','-','-','-','-','-','-','-')
    )
    if ($Difficulty -eq "UniqueSolution") {
        return [System.Array]@(
            [System.Array]@('-','-','-',8,'-',1,'-','-','-'),
            [System.Array]@('-','-','-','-','-','-','-',4,3),
            [System.Array]@(5,'-','-','-','-','-','-','-','-'),
            [System.Array]@('-','-','-','-',7,'-',8,'-','-'),
            [System.Array]@('-','-','-','-','-','-',1,'-','-'),
            [System.Array]@('-',2,'-','-',3,'-','-','-','-'),
            [System.Array]@(6,'-','-','-','-','-','-',7,5),
            [System.Array]@('-','-',3,4,'-','-','-','-','-'),
            [System.Array]@('-','-','-',2,'-','-',6,'-','-')
        )
    }
    if ($Difficulty -eq "Empty") {
        return $StarterArr
    }
    return FindValidSudokuGrid -Grid $StarterArr -NumClues $DIFFICULTYCLUES.$Difficulty
}