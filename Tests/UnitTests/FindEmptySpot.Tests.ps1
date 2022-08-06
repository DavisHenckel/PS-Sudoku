Describe 'FindEmptySpot' {
    It 'Should find 81 empty spots on empty grid' {
        $EmptyGrid = GenerateGrid
        $Ctr = 0
        For ($i = 0; $i -lt 9; $i++) {
            For ($j = 0; $j -lt 9; $j++) {
                If (FindEmptySpot -SudokuGrid $EmptyGrid) {
                    $EmptyGrid[$i][$j] = 1
                    $Ctr += 1
                }
            }
        }
        $Ctr | should -be 81
    }
    It 'Should find 44 empty spots on easy grid' {
        $EasyGrid = GenerateGrid -Difficulty "Easy"
        $Ctr = 0
        $NextSpot = FindEmptySpot -SudokuGrid $EasyGrid
        While ($NextSpot) {
            $Ctr += 1
            $EasyGrid[$NextSpot.Item1 - 1][$NextSpot.Item2 - 1] = 1
            $NextSpot = FindEmptySpot -SudokuGrid $EasyGrid
        }
        $Ctr | should -be 44
    }
    It 'Should find 64 spots on Unique Solution' {
        $UniqueGrid = GenerateGrid -Difficulty UniqueSolution
        $Ctr = 0
        $NextSpot = FindEmptySpot -SudokuGrid $UniqueGrid
        While ($NextSpot) {
            $Ctr += 1
            $UniqueGrid[$NextSpot.Item1 - 1][$NextSpot.Item2 - 1] = 1
            $NextSpot = FindEmptySpot -SudokuGrid $UniqueGrid
        }
        $Ctr | should -be 64
    }
}
