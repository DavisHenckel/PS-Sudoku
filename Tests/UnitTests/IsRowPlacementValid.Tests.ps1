Describe 'IsRowPlacementValid' {
    $SudokuGrid = GenerateGrid
    It 'Ensure empty grid has valid number placement in all rows'{
        For ($i = 0; $i -lt 9; $i++) {
            IsRowPlacementValid $SudokuGrid ($i+1) 1 | Should be $true
        }
    }
    It 'Ensure non-empty grid with invalid number placement is invalid'{
        $SudokuGrid[0][0] = 1
        IsRowPlacementValid $SudokuGrid 1 1 | Should be $false
    }
    It 'Ensure non-empty grid with valid placement is valid'{
        $SudokuGrid[0][0] = 1
        IsRowPlacementValid $SudokuGrid 1 9 | Should be $true
    }
    It 'Ensure out of upper bounds row placement returns error'{
        { IsRowPlacementValid $SudokuGrid 11 2 } | Should Throw 
    }
    It 'Ensure out of lower bounds row placement returns error'{
        { IsRowPlacementValid $SudokuGrid 0 2 } | Should Throw 
    }
    It 'Ensure out of lower bounds row placement returns error'{
        { IsRowPlacementValid $SudokuGrid 1 0 } | Should Throw 
    }
    It 'Ensure out of upper bounds number to place returns error'{
        { IsRowPlacementValid $SudokuGrid 11 20 } | Should Throw 
    }
}