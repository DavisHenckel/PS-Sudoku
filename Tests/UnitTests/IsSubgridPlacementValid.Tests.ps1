Describe 'IsSubgridPlacementValid' {
    $SudokuGrid = GenerateEmptyGrid
    It 'Ensure empty grid has valid number placement in all Subgrids'{
        For ($i = 1; $i -lt 10; $i++) {
            For($j = 1; $j -lt 10; $j++) {
                IsSubgridPlacementValid $SudokuGrid -Row ($i) -Column ($j) -Number 1 | Should be $true 
            }
        }
    }
    It 'Ensure non-empty grid with invalid number placement within subgrid is invalid'{
        $SudokuGrid[0][0] = 1
        IsSubgridPlacementValid $SudokuGrid -Row 2 -Column 3 1 | Should be $false
    }
    It 'Ensure non-empty grid with valid placement is valid'{
        $SudokuGrid[0][0] = 1
        IsSubgridPlacementValid $SudokuGrid -Row 1 -Column 2 -Number 9 | Should be $true
    }
    $SudokuGrid[0][0] = 0 #reset grid
    It 'Ensure out of upper bounds row placement returns error'{
        { IsSubgridPlacementValid $SudokuGrid -Row 11 -Column 2 -Number 1 } | Should Throw 
    }
    It 'Ensure out of lower bounds row placement returns error'{
        { IsSubgridPlacementValid $SudokuGrid -Row 0 -Column 2 -Number 1 } | Should Throw 
    }
    It 'Ensure out of upper bounds column placement returns error'{
        { IsSubgridPlacementValid $SudokuGrid -Row 1 -Column 10 -Number 1 } | Should Throw 
    }
    It 'Ensure out of lower bounds column placement returns error'{
        { IsSubgridPlacementValid $SudokuGrid -Row 1 -Column 0 -Number 1 } | Should Throw 
    }
    It 'Ensure out of upper bounds number to place returns error'{
        { IsSubgridPlacementValid $SudokuGrid -Row 1 -Column 2 -Number 10 } | Should Throw 
    }
    It 'Ensure out of lower bounds number to place returns error'{
        { IsSubgridPlacementValid $SudokuGrid -Row 1 -Column 2 -Number 0 } | Should Throw 
    }
    $SudokuGrid[4][1] = 3
    It 'Additional invalid subgrids tests'{
        
        IsSubgridPlacementValid $SudokuGrid -Row 4 -Column 2 -Number 3 | Should be $false 
    }
    $SudokuGrid[4][5] = 6
    It 'Additional invalid subgrids tests'{
        IsSubgridPlacementValid $SudokuGrid -Row 4 -Column 6 -Number 6 | Should be $false 
    }
    It 'Additional invalid subgrids tests'{
        IsSubgridPlacementValid $SudokuGrid -Row 6 -Column 4 -Number 6 | Should be $false 
    }
    It 'Additional valid subgrids tests'{
        IsSubgridPlacementValid $SudokuGrid -Row 6 -Column 4 -Number 9 | Should be $true 
    }
    It 'Additional valid subgrids tests'{
        IsSubgridPlacementValid $SudokuGrid -Row 6 -Column 1 -Number 2 | Should be $true 
    }
    It 'Additional valid subgrids tests'{
        IsSubgridPlacementValid $SudokuGrid -Row 6 -Column 4 -Number 1 | Should be $true 
    }
}