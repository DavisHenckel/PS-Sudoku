<#
.SYNOPSIS
    Function to play Sudoku
.DESCRIPTION
    Allows a player to play sudoku
.EXAMPLE
    PlaySudoku
.OUTPUTS
    TODO
#>
Function PlaySudoku {
    $DifficultyOptions = [System.Collections.Arraylist]@("Easy","Medium","Hard","Expert","Insane")
    $Difficulty = $null
    Write-Host "Welcome to PS-Sudoku!" -ForegroundColor Green
    while($true) {
        Write-Host "Enter a Difficulty level. The choices are:`n  * Easy`n  * Medium`n  * Hard`n  * Expert`n  * Insane" -ForegroundColor Green
        [string]$Difficulty = Read-Host
        if (($DifficultyOptions.Contains($Difficulty)) -eq $false) {
            Write-Error "You must select one of the described Difficulty levels"
            continue
        }
        break
    }
    Write-Host "Generating a Sudoku puzzle with $Difficulty difficulty..." -ForegroundColor Green
    $SudokuBoard = GenerateGrid -Difficulty "UniqueSolution"
    $OriginalBoard = DeepCopyArray -Source $SudokuBoard #Var to keep track of original board. 
    Write-Host "Board Generated!" -ForegroundColor Green
    Write-Host "This is your Sudoku puzzle..." -ForegroundColor Green
    PrintGrid -SudokuGrid $SudokuBoard
    Write-Host "Have fun!" -ForegroundColor Green
    while ($null -ne (FindEmptySpot -SudokuGrid $SudokuBoard)) {
        $PlayersMove = GetSudokuMove -SudokuGrid $SudokuBoard
        $ValidMove = ValidateSudokuMove -SudokuGrid $SudokuBoard -SudokuMove $PlayersMove
        if ($ValidMove) {
            $Row, $Column, $NumToPlace = (($PlayersMove[1].Item1) - 1), (($PlayersMove[1].Item2) - 1), ($PlayersMove[0])
            $SudokuBoard[$Row][$Column] = $NumToPlace  
            PrintGrid -SudokuGrid $SudokuBoard
        }
        else {
            continue
        }
    }
}

PlaySudoku