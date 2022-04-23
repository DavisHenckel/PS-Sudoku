Describe 'IsRowPlacementValid' {
    BeforeAll {
        $SudokuGrid = GenerateGrid
    }
    It 'Ensure empty grid has valid number placement in all rows'{
        For ($i = 0; $i -lt 9; $i++) {
            IsRowPlacementValid $SudokuGrid ($i+1) 1 | should -be $true
        }
    }
    It 'Ensure non-empty grid with invalid number placement is invalid'{
        $SudokuGrid[0][0] = 1
        IsRowPlacementValid $SudokuGrid 1 1 | should -be $false
    }
    It 'Ensure non-empty grid with valid placement is valid'{
        $SudokuGrid[0][0] = 1
        IsRowPlacementValid $SudokuGrid 1 9 | should -be $true
    }
    It 'Ensure out of upper bounds row placement returns error'{
        { IsRowPlacementValid $SudokuGrid 11 2 } | should -throw 
    }
    It 'Ensure out of lower bounds row placement returns error'{
        { IsRowPlacementValid $SudokuGrid 0 2 } | should -throw 
    }
    It 'Ensure out of lower bounds row placement returns error'{
        { IsRowPlacementValid $SudokuGrid 1 0 } | should -throw 
    }
    It 'Ensure out of upper bounds number to place returns error'{
        { IsRowPlacementValid $SudokuGrid 11 20 } | should -throw 
    }
}