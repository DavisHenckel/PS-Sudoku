<#
.SYNOPSIS
    Main algorithm to generate a random solvable Sudoku board.
.DESCRIPTION
    Picks 10 random numbers and ensures valid placement. Then solves the puzzle and eventually removes a specific number of clues based on the difficulty level.
    This function is kept private due to the fact that it is not meant to be used outside of the GenerateGrid function call.
.PARAMETER Grid
    The grid to return that will be the main Sudoku board. This starts out as an empty grid initialized with all 0s.
.PARAMETER NumClues
    The number of clues to give the Sudoku board. This number is determined from the difficulty level that is passed from the GenerateGrid function.
.EXAMPLE
    FindValidSudokuGrid -Grid $EmptyGrid -NumClues 23
.EXAMPLE
    #An example from the calling function
    GenerateGrid -Difficulty "Hard" 
    #This will return a grid with 23 clues. Reference documentation for GenerateGrid to see how the function is called within it.
.INPUTS
    Takes in an array, and a number of clues.
.OUTPUTS
    Returns a randomly generated solvable Sudoku board with only the number of clues filled out.
#>
Function FindValidSudokuGrid {
    param(
        [parameter(Mandatory=$true)]
        [System.Object]$Grid,
        [parameter(Mandatory=$true)]
        [System.Object]$NumClues
    )
    while ($true) {
        $ReturnGrid = DeepCopyArray $Grid
        #Iterate num clues 10 times. Each iteration, picking a random cell, and setting it to a random value.
        For($i = 0; $i -lt 10; $i++) {
            [int32]$NumToTry = Get-Random -Minimum 1 -Maximum 9
            [int32]$RowToTry = Get-Random -Minimum 0 -Maximum 8
            [int32]$ColToTry = Get-Random -Minimum 0 -Maximum 8
            #Make sure move is valid and is not in use already
            if ((IsMoveValid -SudokuGrid $Grid -Row ($RowToTry+1) -Col ($ColToTry+1) -Number $NumToTry) -and ($Grid[$RowToTry][$ColToTry] -eq 0)) {
                $Grid[$RowToTry][$ColToTry] = $NumToTry #assign the number to the grid
                $ReturnGrid[$RowToTry][$ColToTry] = $NumToTry #update the return grid
                $Grid = DeepCopyArray $ReturnGrid #re-copy the current state of the return grid to the grid
            }
        }
        # Stopwatch to track the length of time. I don't want grid generation to take too long.
        $stopwatch =  [system.diagnostics.stopwatch]::StartNew()
        #If this grid has a valid solution return the grid
        if (SolveSudoku -SudokuGrid $Grid -StopWatch $stopwatch) {
            return (RemoveRandomNumsFromGrid -SolvedGrid $Grid -NumClues $NumClues)
        }
        #otherwise retry the process
        else {
            $Grid = GenerateGrid -Difficulty "Empty"
            $ReturnGrid = DeepCopyArray $Grid
            continue
        }
    }
}
