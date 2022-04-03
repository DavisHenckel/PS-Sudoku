Function SolveSudoku {
    $EasyGrid = GenerateGrid -GridType "Easy"
    SolveSudokuHelper -SudokuGrid $EasyGrid
}