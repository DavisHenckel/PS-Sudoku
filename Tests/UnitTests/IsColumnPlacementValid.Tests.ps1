Describe 'IsColumnPlacementValid' {
    BeforeAll {
        $SudokuGrid = GenerateGrid
    }
    It 'Ensure empty grid has valid number placement in all columns'{
        For ($i = 0; $i -lt 9; $i++) {
            IsColumnPlacementValid $SudokuGrid ($i+1) 1 | should -be $true
        }
    }
    It 'Ensure non-empty grid with invalid number placement is invalid'{
        $SudokuGrid[0][0] = 1
        IsColumnPlacementValid $SudokuGrid 1 1 | should -be $false
    }
    It 'Ensure non-empty grid with valid placement is valid'{
        $SudokuGrid[0][0] = 1
        IsColumnPlacementValid $SudokuGrid 1 9 | should -be $true
    }
    It 'Ensure out of upper bounds column placement returns error'{
        { IsColumnPlacementValid $SudokuGrid 11 2 } | Should -Throw 
    }
    It 'Ensure out of lower bounds column placement returns error'{
        { IsColumnPlacementValid $SudokuGrid 0 2 } | Should -Throw 
    }
    It 'Ensure out of lower bounds column placement returns error'{
        { IsColumnPlacementValid $SudokuGrid 1 0 } | Should -Throw 
    }
    It 'Ensure out of upper bounds number to place returns error'{
        { IsColumnPlacementValid $SudokuGrid 11 20 } | Should -Throw 
    }
}