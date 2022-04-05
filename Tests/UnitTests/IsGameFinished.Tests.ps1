Describe 'IsGameFinished' {
    $Grid = GenerateGrid -Difficulty "Filled"
    It 'Full grid is finished game' {
        IsGameFinished -SudokuGrid $Grid | Should be $true
    }
    It 'One empty space board is not finished' {
        $Grid[8][8] = 0
        IsGameFinished -SudokuGrid $Grid | Should be $false
    }
    It 'EmptyBoard is not finished' {
        $Grid = GenerateGrid -Difficulty "Empty"
        IsGameFinished -SudokuGrid $Grid | Should be $false
    }
}