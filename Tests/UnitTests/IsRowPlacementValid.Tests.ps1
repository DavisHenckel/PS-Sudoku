. ("$PSScriptRoot" + "\..\..\Public\IsRowPlacementValid.ps1") 
Describe 'IsRowPlacementValid' {
    $SudokuGrid = GenerateEmptyGrid
    It 'Ensure empty grid has valid number placement in all rows'{
        For ($i = 0; $i -lt 9; $i++) {
            IsRowPlacementValid $SudokuGrid $i 1 | Should be $true
        }
    }
    It 'Ensure non-empty grid with invalid number placement is invalid'{
        $SudokuGrid[0][0] = 1
        IsRowPlacementValid $SudokuGrid 0 1 | Should be $false
    }
    It 'Ensure non-empty grid with valid placement is valid'{
        $SudokuGrid[0][0] = 1
        IsRowPlacementValid $SudokuGrid 0 9 | Should be $true
    }
}