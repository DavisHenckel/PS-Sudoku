Describe 'GenerateEmptyGrid' {
    $SudokuBoard = GenerateEmptyGrid
    It 'Ensure correct data type of Sudoku grid' {
        $SudokuBoard.GetType() | Should be System.Object[]
    }
    It 'Ensure correct number of lines on Sudoku grid' {
        $SudokuBoard.Length | Should be 9
    }
    It 'Ensure correct items per line in Sudoku grid' {
        ForEach ($Line in $SudokuBoard) {
            $Line.Length | Should be 9
            ForEach ($Item in $Line) {
                $NumCountedElements += 1
            }
        }
    }
    It 'Ensure correct number of counted elements' {
        ForEach ($Line in $SudokuBoard) {
            ForEach ($Item in $Line) {
                $NumCountedElements += 1
            }
        }
        $NumCountedElements | Should be 81
    }
}