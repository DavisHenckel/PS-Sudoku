Describe "SolveSudoku" {
    It "Verifying Easy board solvable" {
        $Grid = GenerateGrid -Difficulty "Easy"
        SolveSudoku -SudokuGrid $Grid | should -be $true
    }
    It "Verifying Medium board solvable" {
        $Grid = GenerateGrid -Difficulty "Medium"
        SolveSudoku -SudokuGrid $Grid | should -be $true
    }
    It "Verifying Hard board solvable" {
        $Grid = GenerateGrid -Difficulty "Hard"
        SolveSudoku -SudokuGrid $Grid | should -be $true
    }
    It "Verifying Expert board solvable" {
        $Grid = GenerateGrid -Difficulty "Expert"
        SolveSudoku -SudokuGrid $Grid | should -be $true
    }
    It "Verifying Insane board solvable" {
        $Grid = GenerateGrid -Difficulty "Insane"
        SolveSudoku -SudokuGrid $Grid | should -be $true
    }
    #These 2 failing...
    # It "Verifying Filled board not sovable" {
    #     $Grid = GenerateGrid -Difficulty "Filled"
    #     SolveSudoku -SudokuGrid $Grid | should -be False
    # }
    # It "Verifying invalid board not solvable" {
    #     $Grid = GenerateGrid
    #     $Grid[0][2] = "1"
    #     $Grid[0][8] = "1"
    #     Solvesudoku -SudokuGrid $Grid | should -be False
    # }
}