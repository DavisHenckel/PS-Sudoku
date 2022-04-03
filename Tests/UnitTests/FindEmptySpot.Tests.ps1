Describe 'FindEmptySpot' {
    It 'Should find 81 empty spots on empty grid' {
        $EmptyGrid = GenerateGrid
        $Ctr = 0
        For ($i = 0; $i -lt 9; $i++) {
            For ($j = 0; $j -lt 9; $j++) {
                if (FindEmptySpot -SudokuGrid $EmptyGrid) {
                    $EmptyGrid[$i][$j] = 1
                    $Ctr += 1
                }
            }
        }
        $Ctr | Should be 81
    }
    It 'Should find 45 empty spots on easy grid' {
        $EasyGrid = GenerateGrid -Difficulty "Easy"
        $Ctr = 0
        $NextSpot = FindEmptySpot -SudokuGrid $EasyGrid
        while ($NextSpot) {
            $Ctr += 1
            $EasyGrid[$NextSpot.Item1 - 1][$NextSpot.Item2 - 1] = 1
            $NextSpot = FindEmptySpot -SudokuGrid $EasyGrid
        }
        $Ctr | Should be 45
    }
}