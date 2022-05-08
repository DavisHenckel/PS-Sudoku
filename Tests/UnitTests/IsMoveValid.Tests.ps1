Describe 'IsMoveValid' {
    BeforeAll {
        $SudokuGrid = GenerateGrid
    }
    It 'Ensure all moves are valid on empty grid' {
        For($i = 1; $i -lt 10; $i++) {
            For($j = 1; $j -lt 10; $j++) {
                For ($k = 1; $k -lt 10; $k++) {
                    IsMoveValid -SudokuGrid $SudokuGrid -Number $i -Row $j -Column $k | should -be $true
                }
            }
        }
    }
    It 'Ensure invalid move if row conflict but column & subgrid OK' {
        $SudokuGrid[0][0] = 1
        IsMoveValid -SudokuGrid $SudokuGrid -Number 1 -Row 1 -Column 6 | should -be $false
        $SudokuGrid[0][0] = '-' #reinitialize
    }
    It 'Ensure invalid move if column conflict but row & subgrid OK' {
        $SudokuGrid[0][2] = 7
        IsMoveValid -SudokuGrid $SudokuGrid -Number 7 -Row 4 -Column 3 | should -be $false
        $SudokuGrid[0][2] = '-' #reinitialize
    }
    It 'Ensure invalid move if subgrid conflict but row & column OK' {
        $SudokuGrid[0][2] = 7
        IsMoveValid -SudokuGrid $SudokuGrid -Number 7 -Row 2 -Column 2 | should -be $false
        $SudokuGrid[0][2] = '-' #reinitialize
    }
    It 'Valid move in non-empty subgrid, row and column' {
        $SudokuGrid[1][1] = 7
        $SudokuGrid[1][2] = 2
        $SudokuGrid[2][1] = 4 
        IsMoveValid -SudokuGrid $SudokuGrid -Number 5 -Row 3 -Column 3 | should -be $true
    }
    It 'Additional valid moves' {
        IsMoveValid -SudokuGrid $SudokuGrid -Number 5 -Row 3 -Column 3 | should -be $true
    }
    It 'Additional valid moves' {
        IsMoveValid -SudokuGrid $SudokuGrid -Number 9 -Row 9 -Column 3 | should -be $true
    }
    It 'Additional valid moves' {
        IsMoveValid -SudokuGrid $SudokuGrid -Number 7 -Row 5 -Column 3 | should -be $true
    }
}