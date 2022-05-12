<#
.SYNOPSIS
    Function to play Sudoku
.DESCRIPTION
    Allows a player to play Sudoku
.EXAMPLE
    PlaySudoku
.OUTPUTS
    Gameplay steps to the console.
.NOTES
    The Sudoku game allows the option to generate a board of any difficulty and then allow the user to play the game.
    If the user gets stuck, there is an option to provide a hint, and or solve the remainder of the puzzle.
    The game is over when the user has solved the puzzle or the algorithm has solved it.
#>
Function PlaySudoku {
    $DifficultyOptions = [System.Collections.Arraylist]@("Easy","Medium","Hard","Expert","Insane")
    $Difficulty = $null
    Write-Host "Welcome to PS-Sudoku!" -ForegroundColor Green
    while($true) {
        Write-Host "Enter a Difficulty level. The choices are:`n  * Easy`n  * Medium`n  * Hard`n  * Expert`n  * Insane`n: " -ForegroundColor Green -NoNewline
        [string]$Difficulty = Read-Host
        if (($DifficultyOptions.Contains($Difficulty)) -eq $false) {
            Write-Error "You must select one of the described Difficulty levels"
            continue
        }
        break
    }
    Write-Host "Generating a Sudoku puzzle with $Difficulty difficulty..." -ForegroundColor Green
    $SudokuBoard = GenerateGrid -Difficulty $Difficulty
    $OriginalBoard = DeepCopyArray -Source $SudokuBoard #Var to keep track of original board. 
    Write-Host "Board Generated!" -ForegroundColor Green
    Write-Host "This is your Sudoku puzzle..." -ForegroundColor Green
    PrintSudokuGridUI -OriginalGrid $OriginalBoard -SudokuGrid $SudokuBoard
    Write-Host "Have fun!" -ForegroundColor Green
    $count = 0
    while ($null -ne (FindEmptySpot -SudokuGrid $SudokuBoard)) {
        if ($count % 5 -eq 0) {
            Write-Host "Enter '-hint' to provide a hint given the current state of your puzzle.`nEnter '-solve' to attempt solving given the current state of your puzzle" -ForegroundColor Yellow
        }
        $PlayersMove = GetSudokuMove -SudokuGrid $SudokuBoard -OriginalGrid $OriginalBoard
        if ($PlayersMove -eq '-hint') {
            Write-Host "Generating a hint given the current puzzle..." -ForegroundColor Yellow
            $CurrentState = DeepCopyArray -Source $SudokuBoard
            $Solvable = SolveSudoku -SudokuGrid $CurrentState
            if ($Solvable) {
                $EmptySpot = FindEmptySpot -SudokuGrid $SudokuBoard
                $Hint = $CurrentState[($EmptySpot.Item1)-1][($EmptySpot.Item2)-1]
                Write-Host -ForegroundColor Cyan "Place $Hint at row:$($EmptySpot.Item1), col:$($EmptySpot.Item2)"
            }
            else {
                Write-Host "The current state of your puzzle is not solvable." -ForegroundColor Red
            }
        }
        elseif ($PlayersMove -eq '-solve') {
            Write-Host "Attempting to solve the current puzzle..." -ForegroundColor Yellow
            $CurrentState = DeepCopyArray -Source $SudokuBoard
            $Solvable = SolveSudoku -SudokuGrid $CurrentState
            if ($Solvable) {
                Write-Host -ForegroundColor Green "The puzzle has been solved!"
                $SudokuBoard = $CurrentState
                PrintSudokuGridUI -OriginalGrid $OriginalBoard -SudokuGrid $SudokuBoard
            }
            else {
                Write-Host "The current state of your puzzle is not solvable." -ForegroundColor Red
            }
        }
        else {
            $ValidMove = ValidateSudokuMove -SudokuGrid $SudokuBoard -SudokuMove $PlayersMove
            if ($ValidMove) {
                $Row, $Column, $NumToPlace = (($PlayersMove[1].Item1) - 1), (($PlayersMove[1].Item2) - 1), ($PlayersMove[0])
                $SudokuBoard[$Row][$Column] = $NumToPlace  
                PrintSudokuGridUI -OriginalGrid $OriginalBoard -SudokuGrid $SudokuBoard
            }
            $count++
        }
    }
    Write-Host "Thanks for playing!" -ForegroundColor Green
}